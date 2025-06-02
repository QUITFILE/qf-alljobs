# QF-AllJobs

A FiveM resource for tracking and exporting job statistics, player names, phone numbers, and online player counts using ESX and oxmysql.

---

## 🇬🇧 English

### Features

- Automatically fetches all jobs from the database or uses a manual job list.
- Tracks the number of players in each job.
- Exports functions for retrieving job counts, player phone numbers, names, and online player counts.
- Debug mode for detailed logging.

### Requirements

- [ESX](https://github.com/esx-framework/esx-legacy)
- [oxmysql](https://github.com/overextended/oxmysql)

### Installation

1. Place this resource in your `resources` folder.
2. Ensure dependencies (`es_extended`, `oxmysql`) are started before this resource.
3. Add to your `server.cfg`:

   ```
   ensure qf-alljobs
   ```

### Configuration

Edit [`shared/general.lua`](shared/general.lua):

- `cfg['debug']`: Enable/disable debug logs.
- `cfg['CheckDatabase']`: Set to `true` to fetch jobs from the database, or `false` to use the manual list.
- `cfg['Transmission']`: Frequency (ms) to send updates to clients.
- `cfg['JobCheckManual']`: List of jobs to track manually.

### Usage

#### Client Exports

- `ClientCheckJob(jobName)` — Get the count of players in a job.
- `ClientPhone()` — Get the player's phone number.
- `ClientName()` — Get the player's name.
- `ClientOnline()` — Get the number of online players.

Example:
```lua
local count = exports[GetCurrentResourceName()]:ClientCheckJob("police")
local phone = exports[GetCurrentResourceName()]:ClientPhone()
local name = exports[GetCurrentResourceName()]:ClientName()
local online = exports[GetCurrentResourceName()]:ClientOnline()
```

#### Server Exports

- `getJobCount(jobName)` — Get the count of players in a job (server-side).

Example:
```lua
local getJobCount = exports[GetCurrentResourceName()]:getJobCount("police")
```

### Commands

- `/reloadjobstats` — Reload and recount all job statistics.

### File Structure

- [`fxmanifest.lua`](fxmanifest.lua) — Resource manifest.
- [`shared/general.lua`](shared/general.lua) — Shared configuration.
- [`core/client_main.lua`](core/client_main.lua) — Client logic.
- [`core/server_main.lua`](core/server_main.lua) — Server logic.

### License

MIT

---

## 🇹🇭 ภาษาไทย

### คุณสมบัติ

- ดึงข้อมูลอาชีพทั้งหมดจากฐานข้อมูลโดยอัตโนมัติ หรือใช้รายการอาชีพที่กำหนดเอง
- ตรวจสอบจำนวนผู้เล่นในแต่ละอาชีพ
- ส่งออกฟังก์ชันสำหรับดึงจำนวนอาชีพ เบอร์โทรศัพท์ ชื่อผู้เล่น และจำนวนผู้เล่นออนไลน์
- โหมดดีบักสำหรับแสดงข้อมูลเพิ่มเติม

### ความต้องการ

- [ESX](https://github.com/esx-framework/esx-legacy)
- [oxmysql](https://github.com/overextended/oxmysql)

### การติดตั้ง

1. วางไฟล์นี้ในโฟลเดอร์ `resources`
2. ตรวจสอบให้แน่ใจว่าได้เริ่มต้น (`es_extended`, `oxmysql`) ก่อน resource นี้
3. เพิ่มใน `server.cfg`:

   ```
   ensure qf-alljobs
   ```

### การตั้งค่า

แก้ไขไฟล์ [`shared/general.lua`](shared/general.lua):

- `cfg['debug']`: เปิด/ปิดการแสดง log debug
- `cfg['CheckDatabase']`: ตั้งค่าเป็น `true` เพื่อดึงอาชีพจากฐานข้อมูล หรือ `false` เพื่อใช้รายการที่กำหนดเอง
- `cfg['Transmission']`: ความถี่ (ms) ในการส่งข้อมูลไปยัง client
- `cfg['JobCheckManual']`: รายการอาชีพที่ต้องการตรวจสอบเอง

### การใช้งาน

#### Client Exports

- `ClientCheckJob(jobName)` — รับจำนวนผู้เล่นในอาชีพนั้น
- `ClientPhone()` — รับเบอร์โทรศัพท์ของผู้เล่น
- `ClientName()` — รับชื่อผู้เล่น
- `ClientOnline()` — รับจำนวนผู้เล่นออนไลน์

ตัวอย่าง:
```lua
local count = exports[GetCurrentResourceName()]:ClientCheckJob("police")
local phone = exports[GetCurrentResourceName()]:ClientPhone()
local name = exports[GetCurrentResourceName()]:ClientName()
local online = exports[GetCurrentResourceName()]:ClientOnline()
```

#### Server Exports

- `getJobCount(jobName)` — รับจำนวนผู้เล่นในอาชีพ (ฝั่งเซิร์ฟเวอร์)

ตัวอย่าง:
```lua
local getJobCount = exports[GetCurrentResourceName()]:getJobCount("police")
```

### คำสั่ง

- `/reloadjobstats` — โหลดและนับสถิติอาชีพใหม่ทั้งหมด

### โครงสร้างไฟล์

- [`fxmanifest.lua`](fxmanifest.lua) — ไฟล์กำหนด resource
- [`shared/general.lua`](shared/general.lua) — ไฟล์ตั้งค่าร่วม
- [`core/client_main.lua`](core/client_main.lua) — โค้ดฝั่ง client
- [`core/server_main.lua`](core/server_main.lua) — โค้ดฝั่ง server

### ลิขสิทธิ์

MIT

