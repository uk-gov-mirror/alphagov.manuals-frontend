require 'gds_api/test_helpers/content_store'
require 'govuk-content-schema-test-helpers'

module ManualHelpers
  include GdsApi::TestHelpers::ContentStore

  def example_hmrc_links
    JSON.parse(
      GovukContentSchemaTestHelpers::Examples.new.get('hmrc_manual', 'vat-government-public-bodies')
    ).fetch("links")
  end

  def example_links
    JSON.parse(
      GovukContentSchemaTestHelpers::Examples.new.get('manual', 'content-design')
    ).fetch("links")
  end

  def stub_education_manual
    manual_json = {
      base_path: "/guidance/buying-for-schools",
      title: "Buying for schools",
      description: "How schools can buy low- to medium-value goods",
      format: "manual",
      first_published_at: "2014-06-20T10:17:29+01:00",
      public_updated_at: "2009-02-20T15:31:09+00:00",
      links: {
        taxons: [{
          title: 'Education, training and skills',
          base_path: '/education',
          description: 'Education, training and skills I guess',
        }]
      },
      details: {
        child_section_groups: [
          {
            title: "Contents",
            child_sections: [
              {
                title: "1. Plan your procurement process",
                description: "How to plan what you need to buy",
                base_path: "/guidance/buying-for-schools/1-plan-your-procurement-process",
              }
            ]
          }
        ],
        organisations: [
          {
            abbreviation: "CO",
            web_url: "http://www.gov.uk/government/organisations/cabinet-office",
            title: "Cabinet Office",
          }
        ],
        change_notes: [
          {
            base_path: "/guidance/buying-for-schools/1-plan-your-procurement-process",
            title: "1. Plan your procurement process",
            change_note: "Added section on procurement",
            published_at: "2014-06-20T09:17:27Z"
          }
        ],
      }
    }

    content_store_has_item("/guidance/buying-for-schools", manual_json)
  end

  def stub_education_manual_section
    section_json = {
      base_path: "/guidance/buying-for-schools/1-plan-your-procurement-process",
      title: "1. Plan your procurement process",
      description: nil,
      format: "manual-section",
      public_updated_at: "2014-01-23T00:00:00+01:00",
      links: example_links,
      details: {
        body: nil,
        section_id: "1. Plan your procurement process",
        child_section_groups: [
          {
            title: "This is a dummy child_section_group title",
            child_sections: [
            ]
          }
        ],
        manual: {
          base_path: "/guidance/buying-for-schools",
        },
      }
    }

    content_store_has_item(
      "/guidance/buying-for-schools/1-plan-your-procurement-process",
      section_json,
      max_age: 20.minutes.to_i,
      private: true,
    )
  end

  def stub_fake_manual(public_updated_at: "2014-06-20T10:17:29+01:00", first_published_at: "2009-02-20T15:31:09+00:00")
    manual_json = {
      base_path: "/guidance/my-manual-about-burritos",
      title: "My manual about Burritos",
      description: "Burrito means little donkey",
      format: "manual",
      first_published_at: first_published_at,
      public_updated_at: public_updated_at,
      links: example_links,
      details: {
        child_section_groups: [
          {
            title: "Contents",
            child_sections: [
              {
                title: "Fillings",
                description: "This section details the fillings.",
                base_path: "/guidance/my-manual-about-burritos/fillings",
              },
              {
                title: "This is the section on hot sauce",
                description: "Hot sauces are good",
                base_path: "/guidance/my-manual-about-burritos/this-is-the-section-on-hot-sauce",
              }
            ]
          }
        ],
        organisations: [
          {
            abbreviation: "CO",
            web_url: "http://www.gov.uk/government/organisations/cabinet-office",
            title: "Cabinet Office",
          }
        ],
        change_notes: [
          {
            base_path: "/guidance/my-manual-about-burritos/fillings",
            title: "Fillings",
            change_note: "Added section on fillings",
            published_at: "2014-06-20T09:17:27Z"
          },
          {
            base_path: "/guidance/my-manual-about-burritos/this-is-the-section-on-hot-sauce",
            title: "This is the section on hot sauce",
            change_note: "Added section on hot sauce",
            published_at: "2014-06-20T09:17:27Z"
          }
        ],
      }
    }

    content_store_has_item("/guidance/my-manual-about-burritos", manual_json)
  end

  def stub_hmrc_manual(manual_id = "inheritance-tax-manual", title = "Inheritance Tax Manual")
    manual_json = {
      base_path: "/hmrc-internal-manuals/#{manual_id}",
      title: title,
      description: nil,
      format: "manual",
      public_updated_at: "2014-01-23T00:00:00+01:00",
      links: example_hmrc_links,
      details: {
        child_section_groups: [
          {
            title: nil,
            child_sections: [
              {
                section_id: "EIM00100",
                base_path: "/hmrc-internal-manuals/#{manual_id}/eim00100",
                title: "About this manual",
              },
              {
                section_id: "EIM00500",
                base_path: "/hmrc-internal-manuals/#{manual_id}/eim00500",
                title: "Inheritance tax",
              },
              {
                section_id: "EIM00900",
                base_path: "/hmrc-internal-manuals/#{manual_id}/eim00900",
                title: "Self assessment tax",
              },
            ]
          }
        ],
        organisations: [
          {
            abbreviation: "HMRC",
            web_url: "http://www.gov.uk/government/organisations/hm-revenue-customs",
            title: "HM Revenue & Customs",
          }
        ],
        change_notes: [],
      }
    }

    content_store_has_item(
      "/hmrc-internal-manuals/#{manual_id}",
      manual_json,
      max_age: 15.minutes.to_i,
    )
  end

  def stub_hmrc_manual_section_with_subsections
    section_json = {
      base_path: "/hmrc-internal-manuals/inheritance-tax-manual/eim00500",
      title: "Inheritance tax: table of contents",
      description: nil,
      format: "manual-section",
      public_updated_at: "2014-01-23T00:00:00+01:00",
      links: example_hmrc_links,
      details: {
        body: nil,
        section_id: "EIM00500",
        child_section_groups: [
          {
            title: "This is a dummy child_section_group title",
            child_sections: [
              {
                section_id: "EIM00510",
                base_path: "/hmrc-internal-manuals/inheritance-tax-manual/eim00510",
                title: "Introduction to particular items",
              },
              {
                section_id: "EIM00520",
                base_path: "/hmrc-internal-manuals/inheritance-tax-manual/eim00520",
                title: "Particular items: A to P",
              },
              {
                section_id: "EIM00530",
                base_path: "/hmrc-internal-manuals/inheritance-tax-manual/eim00530",
                title: "Particular items: R to Z",
              },
            ]
          }
        ],
        manual: {
          base_path: "/hmrc-internal-manuals/inheritance-tax-manual",
        },
      }
    }

    content_store_has_item(
      "/hmrc-internal-manuals/inheritance-tax-manual/eim00500",
      section_json,
      max_age: 20.minutes.to_i,
      private: true,
    )
  end

  def stub_hmrc_manual_sub_sub_section
    section_json = {
      base_path: "/hmrc-internal-manuals/inheritance-tax-manual/eim00520",
      title: "Particular items: A to P",
      description: nil,
      format: "manual-section",
      public_updated_at: "2014-01-23T00:00:00+01:00",
      links: example_hmrc_links,
      details: {
        breadcrumbs: [
          {
            section_id: "EIM00500",
            base_path: "/hmrc-internal-manuals/inheritance-tax-manual/eim00500"
          }
        ],
        body: "Some body to love",
        section_id: "EIM00520",
        manual: {
          base_path: "/hmrc-internal-manuals/inheritance-tax-manual",
        },
      }
    }

    content_store_has_item("/hmrc-internal-manuals/inheritance-tax-manual/eim00520", section_json)
  end

  def stub_hmrc_manual_section_with_body(manual_id = "inheritance-tax-manual", section_id = "eim15000",
                                         title = "Parent-financed and non-approved retirement benefits schemes: table of contents")
    section_json = {
      base_path: "/hmrc-internal-manuals/#{manual_id}/#{section_id}",
      title: title,
      description: nil,
      format: "manual-section",
      public_updated_at: "2014-01-23T00:00:00+01:00",
      links: example_hmrc_links,
      details: {
        body: 'On this page:<br><br><a href="/hmrc-internal-manuals/#{manual_id}/#{section_id}#EIM15010#IDAZR1YH">Sections 386-400 ITEPA 2003]</a><br>',
        section_id: section_id,
        child_section_groups: [],
        manual: {
          base_path: "/hmrc-internal-manuals/#{manual_id}",
        },
      }
    }

    content_store_has_item("/hmrc-internal-manuals/#{manual_id}/#{section_id}", section_json)
  end

  def stub_withdrawn_manual(base_path)
    gone_json = {
      base_path: base_path,
      format: "gone",
      phase: "live",
    }

    content_store_has_item(base_path, gone_json)
  end
end

RSpec.configuration.include ManualHelpers
