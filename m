Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 259FBC43334
	for <linux-fstests@archiver.kernel.org>; Wed, 22 Jun 2022 04:37:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356910AbiFVEha (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 22 Jun 2022 00:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356882AbiFVEh3 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 22 Jun 2022 00:37:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C2C3035844
        for <fstests@vger.kernel.org>; Tue, 21 Jun 2022 21:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655872647;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TnkxnTVSprA5O2NqLN5BKipQ+i/2WGt6FHdnISs3jbw=;
        b=GNrX9iVfaJVD5zxshoPVd4TlQWSWZCVvXVEux79OXXI9WYW2OeDwKzIMo+1DUp0xo2WYs0
        8mAE4n7HFgohVTk9Iu8x9aF/wqDJ4VI9zDfGLDBJYC3qEX3Yqpmk576Cd2nyYSB5tTowXz
        Gmugv1ZbAmxKJOx6noYbKl4iPF+NXWA=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-189-SGt5zERGPqC9PfV6vdSEUQ-1; Wed, 22 Jun 2022 00:37:26 -0400
X-MC-Unique: SGt5zERGPqC9PfV6vdSEUQ-1
Received: by mail-qk1-f197.google.com with SMTP id bl27-20020a05620a1a9b00b0069994eeb30cso18678320qkb.11
        for <fstests@vger.kernel.org>; Tue, 21 Jun 2022 21:37:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TnkxnTVSprA5O2NqLN5BKipQ+i/2WGt6FHdnISs3jbw=;
        b=xZK6rLjoHlqH/5SqNbz9yieONgFx76Nu+o043hINteXyxJRw3CrKF1c42LeYdYnblz
         LwCaJONceyL2rYzl5Myt8sW0cRiVycdcNjbCvFeCi7sbHXpm1njQ70FeRMLo/IMm4Dj/
         wsntiYZQL3g63P65bz1C5dDPj9rJ4O5ZtrzMkqUk5VP26UqdXQwmYjCCBcAAw6RtZ+gD
         LrwDBJc5HKHv1DvIjhXzmEmCM0X9pOoIk4chIm1pT3xRh56oEPNItK7+u4E4geQheTBp
         jxvrlb3FP6tWlBaYKmtJQsx3hO6E23BuXPlebyxYCwUHmyj9lJrnqttSfP5dnv5abVnt
         LB3w==
X-Gm-Message-State: AJIora+DXnwuG7ro0cuOMdQp+RntIRX1mmgUxJQg6dp+gcyD1mGA/AgT
        YnZOSUucQz7ODQweePvCCyiNy9taTJA/ov6T17BdnVtIw5lc+EP6kCkCUWsQ0Dm/0X1EM9Bwy6P
        ZaezRYcHcIYyDczC7SQ==
X-Received: by 2002:ac8:7c52:0:b0:305:a14:6f77 with SMTP id o18-20020ac87c52000000b003050a146f77mr1397800qtv.441.1655872645660;
        Tue, 21 Jun 2022 21:37:25 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sc1WC7xQsEO4h/DURjuuwRvBYn+qRdwKHyps7i+9L0F25Y5mo9pL6v9FMiSzeW/V7jSBOSwg==
X-Received: by 2002:ac8:7c52:0:b0:305:a14:6f77 with SMTP id o18-20020ac87c52000000b003050a146f77mr1397791qtv.441.1655872645245;
        Tue, 21 Jun 2022 21:37:25 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id bq38-20020a05620a46a600b006a785ba0c25sm14864836qkb.77.2022.06.21.21.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 21:37:24 -0700 (PDT)
Date:   Wed, 22 Jun 2022 12:37:18 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     David Disseldorp <ddiss@suse.de>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH 3/6] report: drop unused _xunit_make_section_report
 parameter
Message-ID: <20220622043718.pcdgu6n2mhbijv4x@zlang-mailbox>
References: <20220620192934.21694-1-ddiss@suse.de>
 <20220620192934.21694-4-ddiss@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220620192934.21694-4-ddiss@suse.de>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Jun 20, 2022 at 09:29:31PM +0200, David Disseldorp wrote:
> Signed-off-by: David Disseldorp <ddiss@suse.de>
> ---
>  common/report | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/common/report b/common/report
> index 6cac71fc..bf05afa9 100644
> --- a/common/report
> +++ b/common/report
> @@ -152,7 +152,7 @@ _make_section_report()
>  	for report in $REPORT_LIST; do
>  		case "$report" in
>  		"xunit")
> -			_xunit_make_section_report "$test_status"
> +			_xunit_make_section_report

Hmm... I checked the history about _xunit_make_section_report, it was brought in
by f9fde7db2fa5 ("report: Add xunit format report generator") in 2017. But
it doesn't use any arguments at that time. So this "$test_status" is useless
from beginning.

Reviewed-by: Zorro Lang <zlang@redhat.com>


>  			;;
>  		*)
>  			_dump_err "format '$report' is not supported"
> -- 
> 2.35.3
> 

