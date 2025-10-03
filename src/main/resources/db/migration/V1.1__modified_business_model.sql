alter table businesses
  add column favorite_id bigint,
  add constraint fk_favorite_id foreign key (favorite_id) references favorites(id)