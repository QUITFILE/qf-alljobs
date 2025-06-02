cfg = {}

cfg['debug'] = true -- เปิด/ปิด debug mode

-- ✅ ให้ระบบไปดึงชื่ออาชีพทั้งหมดจากฐานข้อมูล jobs (SQL) อัตโนมัติ
cfg['CheckDatabase'] = true

-- ⏱ ความถี่ในการส่งข้อมูลไปยัง client (มิลลิวินาที)
cfg['Transmission'] = 1000 -- = 1 วินาที

-- 📋 รายชื่อ job ที่ใช้ตรวจสอบแบบ manual (ต้องตรงกับชื่อในฐานข้อมูล jobs.name)
cfg['JobCheckManual'] = {'police', 'ambulance', 'council' -- 'Job2',
-- 'Job3',
-- 'Job4',
}

-- -- client
-- local count = exports[GetCurrentResourceName()]:ClientCheckJob("police")
-- local phone = exports[GetCurrentResourceName()]:ClientPhone()
-- local name = exports[GetCurrentResourceName()]:ClientName()
-- local online = exports[GetCurrentResourceName()]:ClientOnline()
-- -- server
-- local getJobCount = exports[GetCurrentResourceName()]:getJobCount("police")

-- -- ตัวอย่างการใช้งาน
-- print("Police Count: " .. count)
-- print("Player Phone: " .. phone)
-- print("Player Name: " .. name)
-- print("Online Players: " .. online)
-- print("Get Job Count: " .. getJobCount)
-- -- ตัวอย่างการใช้งาน
