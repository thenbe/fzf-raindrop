import random
from datetime import datetime, timedelta

import faker
import pandas as pd

# Generate fake data
new_rows = []
fake = faker.Faker()
for _ in range(1000):
    new_row = {
        "title": fake.sentence(),
        "note": fake.sentence(),
        "excerpt": fake.paragraph(),
        "url": fake.url(),
        "tags": ", ".join(fake.words(random.randint(0, 4))),
        "created": (
            datetime.now() - timedelta(days=random.randint(1, 365))
        ).isoformat(),
        "cover": fake.image_url(),
        "highlights": fake.sentence(),
    }
    new_rows.append(new_row)

# Save to a csv file
new_df = pd.DataFrame(new_rows)
new_df.to_csv("generated/latest.csv", index=False)
