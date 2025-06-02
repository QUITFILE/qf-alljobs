cfg = {}

cfg['debug'] = true -- เปิด/ปิด debug mode

-- ✅ ให้ระบบไปดึงชื่ออาชีพทั้งหมดจากฐานข้อมูล jobs (SQL) อัตโนมัติ
cfg['CheckDatabase'] = true

-- ⏱ ความถี่ในการส่งข้อมูลไปยัง client (มิลลิวินาที)
cfg['Transmission'] = 1000 -- = 1 วินาที

-- 📋 รายชื่อ job ที่ใช้ตรวจสอบแบบ manual (ต้องตรงกับชื่อในฐานข้อมูล jobs.name)
cfg['JobCheckManual'] = {'police', 'ambulance', 'council', 'taxi', 'mechanic', 'trucker', 'fisherman', 'miner', 'garbage'}
