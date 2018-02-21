*----------------------------------------------------------------------*
*   INCLUDE ZBC_USER_01_TOP                                            *
*----------------------------------------------------------------------*
* DB-Tabellen
TABLES: ltdxt,
        usr02,
        zbc_never_delete.
*
TYPE-POOLS vrm.
*
* Typdefinition
TYPES: BEGIN OF typ_out,
       bname LIKE usr02-bname,
       trdat LIKE usr02-trdat,
       gltgb LIKE usr02-gltgb,
       gltgv LIKE usr02-gltgv,
       text(256) TYPE c,
       amp   TYPE c,
END OF typ_out.
*
* Interne Tabellen
DATA:  it_out      TYPE STANDARD TABLE OF typ_out,
       i_bdcdata   LIKE bdcdata    OCCURS 0 WITH HEADER LINE,
       i_messages  LIKE bdcmsgcoll OCCURS 0 WITH HEADER LINE.
*
* Für Selection-Boxen
DATA:  id       TYPE vrm_id,
       it_value TYPE STANDARD TABLE OF vrm_value,
       wa_value LIKE LINE OF it_value.
*
* Workarea
DATA:  BEGIN OF wa_out,
       bname LIKE usr02-bname,
       trdat LIKE usr02-trdat,
       gltgb LIKE usr02-gltgb,
       gltgv LIKE usr02-gltgv,
       text(256) TYPE c,
       amp   TYPE c,
END OF wa_out.
*
* Feldsymbole
FIELD-SYMBOLS: <out> LIKE LINE OF it_out.
*
SELECTION-SCREEN BEGIN OF BLOCK sel WITH FRAME TITLE text-006.
SELECT-OPTIONS: s_bname FOR usr02-bname.
SELECTION-SCREEN END OF BLOCK sel.
*
SELECTION-SCREEN BEGIN OF BLOCK upd WITH FRAME TITLE text-007.
PARAMETERS:     p_test   TYPE c AS LISTBOX VISIBLE LENGTH 15
                                         OBLIGATORY DEFAULT '1'.
SELECTION-SCREEN END OF BLOCK upd.
*
INCLUDE zbc_alv_top.
INCLUDE zbc_alv_form.
*
INITIALIZATION.
*
  h_title  = 'Listlayout'.
  h_layout = 'Layout'.
*
  CLEAR: it_value[].
  wa_value-key = '1'.
  wa_value-text = 'Testlauf'.
  INSERT wa_value INTO TABLE it_value.

  wa_value-key = '2'.
  wa_value-text = 'Echtlauf'.
  INSERT wa_value INTO TABLE it_value.
*
  CALL FUNCTION 'VRM_SET_VALUES'
       EXPORTING
            id     = 'P_TEST'
            values = it_value.
