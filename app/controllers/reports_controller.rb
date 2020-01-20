class ReportsController < ApplicationController
  before_action :auth
  before_action :set_title
  before_action :set_report, only: [:show, :edit, :update, :destroy]

  # GET /reports
  # GET /reports.json
  def index
    @reports = Report.order(created_at: :desc)
  end

  # GET /reports/1
  # GET /reports/1.json
  def show
  end

  # GET /reports/new
  def new
    @report = Report.new
  end

  # GET /reports/1/edit
  def edit
  end

  # POST /reports
  # POST /reports.json
  def create
    tag_codes = report_params["tags"]
    report_params.delete("tags")
    @report = Report.new(report_params)

    respond_to do |format|
      if @report.save

        unless tag_codes.blank?
          ReportTag.add(@report.code, tag_codes)
        end

        format.html { redirect_to admin_reports_path, notice: 'Report was successfully created.' }
        format.json { render :show, status: :created, location: @report }
      else
        format.html { render :new }
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reports/1
  # PATCH/PUT /reports/1.json
  def update
    tag_codes = report_params["tags"]
    report_params.delete("tags")

    respond_to do |format|
      if @report.update(report_params)

        unless tag_codes.blank?
          ReportTag.update_report(@report.code, tag_codes)
        end

        format.html { redirect_to admin_reports_path, notice: 'Report was successfully updated.' }
        format.json { render :show, status: :ok, location: @report }
      else
        format.html { render :edit }
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reports/1
  # DELETE /reports/1.json
  def destroy
    @report.destroy
    respond_to do |format|
      format.html { redirect_to admin_reports_path, notice: 'Report was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_title
      @title = "Report"
    end  

    # Use callbacks to share common setup or constraints between actions.
    def set_report
      @report = Report.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def report_params
      params.require(:report).permit!
    end
end
