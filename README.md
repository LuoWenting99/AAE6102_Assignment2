# AAE6102_Assignment2
# AAE6102 Assignment 2 Report

# Task 1 -- Differential GNSS Positioning

This essay compares the pros and cons of four GNSS techniques for smartphone navigation:  
- **Differential GNSS (DGNSS)**  
- **Real-Time Kinematic (RTK)**  
- **Precise Point Positioning (PPP)**  
- **PPP-RTK**  

---

## Precision

### DGNSS
- **Improvement**: Reduces horizontal errors to ~1.75 meters and vertical errors to ~4.5 meters using L5 corrections.  
- **Limitations**: Smartphone antennas (linearly polarized) are prone to multipath interference, restricting sub-meter accuracy.  

### RTK
- **Professional Use**: Achieves 1–2 cm accuracy with stable carrier phase measurements.  
- **Smartphone Challenges**: Unstable phase measurements lead to float solutions (>1 meter errors). Requires base stations within 10–20 km.  

### PPP
- **Global Solution**: Decimeter to sub-meter accuracy after convergence (seconds to minutes).  
- **Drawbacks**: Lower precision than RTK; vertical accuracy less reliable.  

### PPP-RTK
- **Hybrid Performance**: Centimeter-level horizontal accuracy, decimeter vertical, ~60s convergence.  
- **Adoption**: Early stages for smartphones due to hardware/software maturity requirements.  

---

## Cost

| Technique | Cost Implications                                                                 |
|-----------|-----------------------------------------------------------------------------------|
| DGNSS     | Low cost; uses existing corrections and standard chipsets. Requires data/software. |
| RTK       | High cost; needs external antennas, base station corrections (e.g., NTRIP).        |
| PPP       | Moderate cost; single receiver + internet/satellite corrections. Battery/data impact. |
| PPP-RTK   | Moderate-high cost; advanced chipsets + regional CORS networks. Emerging tech.     |

---

## Infrastructure Requirements

| Technique | Infrastructure Needs                                                                 |
|-----------|--------------------------------------------------------------------------------------|
| DGNSS     | Local reference stations; limited to populated areas.                                |
| RTK       | Dense local base stations + bidirectional comms; costly and unscalable.              |
| PPP       | Global corrections via satellite/internet; no local infrastructure.                  |
| PPP-RTK   | Regional CORS networks; degrades to PPP outside coverage. More scalable than RTK.    |

---

## Summary Table

| Technique | Precision on Smartphones   | Cost    | Infrastructure               | Key Pros                          | Key Cons                          |
|-----------|----------------------------|---------|-------------------------------|-----------------------------------|-----------------------------------|
| DGNSS     | ~1.75 m (horizontal)       | Low     | Local reference stations      | Low cost, easy to implement       | Limited precision, coverage       |
| RTK       | Centimeter-level (hard)    | High    | Local base stations + comms   | Highest precision                 | Complex hardware, limited coverage, costly |
| PPP       | Decimeter to sub-meter     | Moderate| Global corrections            | Global, no base stations needed   | Longer convergence, lower precision than RTK |
| PPP-RTK   | Centimeter (horizontal), decimeter (vertical) | Moderate-high | Regional CORS + broadcast | RTK accuracy + PPP scalability | Emerging tech, infrastructure gaps |

---

## Conclusion

- **RTK**: Best precision but impractical for smartphones due to hardware/infrastructure.  
- **DGNSS**: Cost-effective but limited accuracy/coverage.  
- **PPP**: Balanced global solution with moderate accuracy.  
- **PPP-RTK**: Future potential to combine RTK precision and PPP scalability for smartphones.  

---

**Model Used**: Perplexity.AI  
**Reference Chatroom**: [GNSS Concepts Explanation](https://www.perplexity.ai/search/can-you-explain-the-basic-conc-1ctOtrgKQfKMqQZe7sQ5Bg)  

## Task 2 -- GNSS in Urban Areas

### Methodology
1. **Sky Mask Processing**: Cubic spline interpolation for elevation thresholds
2. **Satellite Visibility Screening**: Discard satellites below elevation threshold
3. **Weighted Least Squares (WLS) Positioning**

### Results
| Method                | East (m) | North (m) | Up (m)  |
|-----------------------|----------|-----------|---------|
| Original WLS          | 509.43   | 222.57    | 1875.27 |
| Sky Mask Enhanced WLS | 255.93   | 111.41    | 941.62  |

## Task 3 -- GPS RAIM

### Implementation
- Classic weighted RAIM algorithm based on WLS
- Detects/excludes faulty measurements
- Bonus: 3D Protection Level calculation (P_fa=10^-2, P_md=10^-7, σ=3m)

### Results
- Latitude/Longitude predictions match ground truth closely
- Height estimation error: 2.08m average
- Stanford Chart analysis shows compliance with 50m 3D Alarm Limit

![RAIM Performance](images/a.png)
![Error Distribution](images/b.png)

## Task 4 -- LEO Satellites for Navigation

### Challenges
- **High Doppler Shifts**: Due to rapid orbital velocity (~7.8 km/s)
- **Dynamic Geometry**: Requires large constellations (1000s of satellites)
- **Ephemeris Availability**: Lack of public orbital/clock data
- **Atmospheric Drag**: Causes orbital decay and perturbations
- **Receiver Complexity**: Needs high-dynamic tracking capabilities

## Task 5 -- GNSS Remote Sensing (GNSS-R)

### Key Applications
- **Oceanography**: Sea surface wind/wave monitoring (e.g., NASA CYGNSS)
- **Hydrology**: Soil moisture mapping (e.g., EOS-08 satellite)
- **Cryosphere**: Ice thickness monitoring
- **Disaster Management**: Flood detection and monitoring

### Advantages
- Passive operation using existing GNSS signals
- All-weather capability (L-band penetration)
- Global coverage with frequent revisits
- Multi-platform deployment (ground, air, space)

