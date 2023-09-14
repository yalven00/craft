class AlterAssets < ActiveRecord::Migration
  def change
    add_column :assets, :asset_type, :string, default: 'asset'
    add_column :assets, :for_model, :string, default: 'project'
    add_column :assets, :mid, :integer
    # Asset.all.each{|a| Asset.create(asset_type: 'asset', for_model: 'project', mid: a.project_id, file: a.file) }
    # Transcript.all.each{|t| Asset.create(asset_type: 'transcript', for_model: 'education', mid: t.education_id, file: t.file)}
    # remove_column :assets, :education_id, :integer
    # remove_column :assets, :project_id, :integer
  end
end
