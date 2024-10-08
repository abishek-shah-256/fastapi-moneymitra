"""adding timestampmixin

Revision ID: 113725c3b87e
Revises: de74783a8900
Create Date: 2024-08-11 19:48:43.730288

"""
from typing import Sequence, Union

from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision: str = '113725c3b87e'
down_revision: Union[str, None] = 'de74783a8900'
branch_labels: Union[str, Sequence[str], None] = None
depends_on: Union[str, Sequence[str], None] = None


def upgrade() -> None:
    # ### commands auto generated by Alembic - please adjust! ###
    op.add_column('portfolio_data_advisory', sa.Column('created_at', sa.DateTime(), nullable=True))
    op.add_column('portfolio_data_advisory', sa.Column('updated_at', sa.DateTime(), nullable=True))
    # ### end Alembic commands ###


def downgrade() -> None:
    # ### commands auto generated by Alembic - please adjust! ###
    op.drop_column('portfolio_data_advisory', 'updated_at')
    op.drop_column('portfolio_data_advisory', 'created_at')
    # ### end Alembic commands ###
