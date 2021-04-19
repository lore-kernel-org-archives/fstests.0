Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77CCCC433B4
	for <linux-fstests@archiver.kernel.org>; Mon, 19 Apr 2021 22:06:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52D82613AA
	for <linux-fstests@archiver.kernel.org>; Mon, 19 Apr 2021 22:06:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbhDSWHW (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 19 Apr 2021 18:07:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44662 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229806AbhDSWHW (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 19 Apr 2021 18:07:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618870012;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Twzc/iCdWWS0h7Jv7PDyP+MOH9BAkxKXCAqUZT4iUuw=;
        b=hIgp8z3lSlCZvtY1q7A5Kid5mUsUIXlB5kuw5CCyvHNXMjPaPgA+iIGkdgtWwznvxifeZ4
        TWjr2igL15AUxsKWcX7igoojFhHNfg1vJIh3LEY8PSjw2BxHG2NJ8/bzC5FMGuw+H+fiZy
        ie/xf/2EKQrbk8epwUzMM0Y2TPQ00gA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-475-hmz6izcYOZ2Mq0NLqkEwZg-1; Mon, 19 Apr 2021 18:06:50 -0400
X-MC-Unique: hmz6izcYOZ2Mq0NLqkEwZg-1
Received: by mail-wr1-f69.google.com with SMTP id j4-20020adfe5040000b0290102bb319b87so9748074wrm.23
        for <fstests@vger.kernel.org>; Mon, 19 Apr 2021 15:06:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Twzc/iCdWWS0h7Jv7PDyP+MOH9BAkxKXCAqUZT4iUuw=;
        b=Pb+5L+RenSvAKlVGe0QFuI9fM1Ju/aWzYlufYF3E4n9cjz0MDu97s4yfF/A3cWfOqx
         LHKr0nBl83agrGd7zIwSJZsxFX9rdq+1nB+O0OMrdJDIjiAP0UXho17iuJXIIbMDqwp3
         dosKvsac10DNkVzYBwSmcFbqMXk7T1SA+hXd69vlX2UyZPHw3dmyEcCrL2EPTwzqG40a
         fbUIWTnVl4067c+U9ZikJR3oNvTjVmrqPAgmQJT03S7I8K3ICcoy87amxyEMtraw7Lfb
         aJO+/nGKb/j5DNqW49mCj9THwtyrvXst6f4Dtsev8X2hhfSpj9FLs7QUrLuBffYLl49y
         3l/w==
X-Gm-Message-State: AOAM530470uGN4Gp7s54250+vN1XEquc8TlBmNEz/nNWcfqakUrQz2xP
        wGZNnH/MvJsLdgZkLNyw3saWx/7WaOyHn/w0nTVDG+OKgTCbzPgbQRky8QUL+oMP8a8eWGkUK9R
        GR9EE0WZORohNXkVn5sARf/WBA9qAX5edZjxbnHL3om2xKfGQtW9zd5yJExR0Wvsm7NwR
X-Received: by 2002:a7b:cc10:: with SMTP id f16mr1078377wmh.131.1618870008914;
        Mon, 19 Apr 2021 15:06:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxNMLzc66LuyETvuV9k0zVUsvhhPBdko6EEexshKDImMike/INWkblXXpoMb+TfDC2pT4KlOg==
X-Received: by 2002:a7b:cc10:: with SMTP id f16mr1078365wmh.131.1618870008773;
        Mon, 19 Apr 2021 15:06:48 -0700 (PDT)
Received: from localhost.localdomain ([84.19.91.9])
        by smtp.gmail.com with ESMTPSA id a15sm24060023wrr.53.2021.04.19.15.06.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Apr 2021 15:06:48 -0700 (PDT)
Subject: Re: [PATCH v3 1/4] common/rc: Add _require_{chown,chmod}()
To:     Eryu Guan <guan@eryu.me>
Cc:     fstests@vger.kernel.org
References: <20210415094905.61853-1-preichl@redhat.com>
 <20210415094905.61853-2-preichl@redhat.com> <YHwq/hmeTmGktR/G@desktop>
From:   Pavel Reichl <preichl@redhat.com>
Message-ID: <882c5aad-4e0c-ba20-6007-dabdbf1ced11@redhat.com>
Date:   Tue, 20 Apr 2021 00:06:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YHwq/hmeTmGktR/G@desktop>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org



On 4/18/21 2:50 PM, Eryu Guan wrote:
> On Thu, Apr 15, 2021 at 11:49:02AM +0200, Pavel Reichl wrote:
...
>> +#
>> +_require_chmod()
>> +{
>> +	_require_chown
> 
> It's not clear to me why _require_chown also works for _require_chmod,
> other than actually doing chmod test. Some comments would be good.

Yeah, sorry about that. I just sent v4 of this patch that attempts to implement _require_chmod() properly.

> 
> Thanks,
> Eryu
> 
> P.S. I've applied other patches in this patchset, thanks for the fixes!

Awesome, thanks for the reviews.

> 

