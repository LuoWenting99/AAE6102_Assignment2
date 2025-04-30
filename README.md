# AAE6102_Assignment2
# AAE6102 Assignment 2 Report

## Task 1 -- Differential GNSS Positioning

### Comparison of GNSS Techniques for Smartphone Navigation

#### Precision
- **DGNSS**: ~1.75m horizontal, 4.5m vertical accuracy
- **RTK**: Centimeter-level (challenging on smartphones)
- **PPP**: Decimeter to sub-meter accuracy
- **PPP-RTK**: Centimeter-level horizontal, decimeter vertical

#### Cost
- **DGNSS**: Low cost
- **RTK**: High cost (requires external hardware)
- **PPP**: Moderate cost
- **PPP-RTK**: Moderate to high cost

#### Infrastructure Requirements
- **DGNSS**: Needs local reference stations
- **RTK**: Requires dense base station network
- **PPP**: Global coverage via satellite/internet
- **PPP-RTK**: Regional CORS networks

| Technique | Precision on Smartphones | Cost  | Infrastructure         | Key Pros               | Key Cons                  |
|-----------|--------------------------|-------|------------------------|------------------------|---------------------------|
| DGNSS     | ~1.75m horizontal        | Low   | Local reference stations | Low cost, easy to implement | Limited precision        |
| RTK       | Centimeter-level         | High  | Local base stations    | Highest precision      | Hardware complexity      |
| PPP       | Decimeter to sub-meter   | Moderate | Global corrections    | Global coverage        | Longer convergence       |
| PPP-RTK   | Centimeter-level horizontal | Moderate | Regional CORS       | Combines RTK/PPP       | Emerging technology      |

### Conclusion
RTK offers highest precision but is impractical for smartphones. PPP provides global coverage while PPP-RTK emerges as promising hybrid solution.

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

