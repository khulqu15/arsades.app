import mysql, {
    type Pool,
    type PoolConnection,
    type ResultSetHeader,
    type RowDataPacket
} from 'mysql2/promise'

export type DbParams = Array<string | number | boolean | null | Date>

declare global {
    // eslint-disable-next-line no-var
    var __mysqlPool: Pool | undefined
}

function required(key: string) {
    const value = process.env[key]

    if (!value) {
        throw createError({
            statusCode: 500,
            statusMessage: `Missing database config: ${key}`
        })
    }

    return value
}

export function getMysqlPool() {
    if (globalThis.__mysqlPool) return globalThis.__mysqlPool

    globalThis.__mysqlPool = mysql.createPool({
        host: required('DATABASE_HOST'),
        port: Number(process.env.DATABASE_PORT || 3306),
        user: required('DATABASE_USER'),
        password: required('DATABASE_PASSWORD'),
        database: required('DATABASE_NAME'),

        waitForConnections: true,
        connectionLimit: Number(process.env.DATABASE_CONNECTION_LIMIT || 10),
        queueLimit: 0,

        connectTimeout: 15000,
        timezone: 'Z',

        decimalNumbers: true,
        dateStrings: false
    })

    return globalThis.__mysqlPool
}

export async function dbQuery<T extends RowDataPacket[]>(sql: string, params: DbParams = [], connection?: PoolConnection) {
    const executor = connection || getMysqlPool()
    const [rows] = await executor.execute<T>(sql, params)
    return rows
}

export async function dbExecute(sql: string, params: DbParams = [], connection?: PoolConnection) {
    const executor = connection || getMysqlPool()
    const [result] = await executor.execute<ResultSetHeader>(sql, params)
    return result
}

export async function withTransaction<T>(callback: (connection: PoolConnection) => Promise<T>) {
    const connection = await getMysqlPool().getConnection()

    try {
        await connection.beginTransaction()
        const result = await callback(connection)
        await connection.commit()
        return result
    } catch (error) {
        await connection.rollback()
        throw error
    } finally {
        connection.release()
    }
}
