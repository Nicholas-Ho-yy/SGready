const {onRequest} = require("firebase-functions/v2/https");

exports.dataGovProxy = onRequest(
  {
    region: "asia-southeast1",
    cors: true,
  },
  async (req, res) => {
    try {
      const endpoint = req.query.endpoint;

      const allowedEndpoints = new Set([
        "psi",
        "uv",
        "rainfall",
        "air-temperature",
        "wbgt",
      ]);

      if (!endpoint || !allowedEndpoints.has(endpoint)) {
        res.status(400).json({
          error: "Invalid environmental endpoint",
        });
        return;
      }

      let url =
        `https://api-open.data.gov.sg/v2/real-time/api/${endpoint}`;

      if (endpoint === "wbgt") {
        url =
          "https://api-open.data.gov.sg/v2/real-time/api/weather?api=wbgt";
      }

      const response = await fetch(url);

      const body = await response.text();

      res
        .status(response.status)
        .set("Content-Type", "application/json")
        .send(body);
    } catch (error) {
      console.error(error);

      res.status(500).json({
        error: "Unable to retrieve environmental data",
      });
    }
  },
);