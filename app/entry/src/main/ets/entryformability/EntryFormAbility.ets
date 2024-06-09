

import FormExtensionAbility from '@ohos.app.form.FormExtensionAbility';
import formBindingData from '@ohos.app.form.formBindingData';
import FormInfo from '../viewmodel/FormInfo';
import FormUtils from '../common/utils/FormUtils';
import { CommonConstants as Const } from '../common/constants/CommonConstants';
import Want from '@ohos.app.ability.Want';

export default class EntryFormAbility extends FormExtensionAbility {
  onAddForm(want: Want) {
    let parameters = want.parameters;
    if (parameters) {
      let formId: string = parameters[Const.FORM_PARAM_IDENTITY_KEY] as string;
      let formName: string = parameters[Const.FORM_PARAM_NAME_KEY] as string;
      let formDimension: number = parameters[Const.FORM_PARAM_DIMENSION_KEY] as number;
      let formInfo: FormInfo = {
        formId: formId,
        formName: formName,
        formDimension: formDimension
      };
      FormUtils.insertFormData(this.context, formInfo);
    }
    let formData = formBindingData.createFormBindingData('');
    return formData;
  }

  onUpdateForm() {
    FormUtils.updateCards(this.context);
  }

  onRemoveForm(formId: string) {
    FormUtils.deleteFormData(this.context, formId);
  }
}