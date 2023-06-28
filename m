Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F22FAEB64D7
	for <linux-fstests@archiver.kernel.org>; Wed, 28 Jun 2023 09:19:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233717AbjF1JTz (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 28 Jun 2023 05:19:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45544 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232338AbjF1IyM (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 28 Jun 2023 04:54:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687942368;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lMefUSJfK9VBdCYF+2+lrwTVUlwXDm4Z+5YHx5byeoY=;
        b=IS7akdmCSekycOjw74FOldbBr3h4PGWSMjsUSO2drhKNaylnUZYBTWSogQwZLthOPzSVjj
        GZlH2jK4aFn9j6fZSwH1rHhUNDwSv3VXN3dEj02ElyVhGgYA2HjrLIcVAViZc02Ca9aVi/
        rgfQdHG0DoeUZM+RW3KdLkvLlqPWAfo=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-8-FBTR2d-9OuiEfuNvpw0wYA-1; Wed, 28 Jun 2023 04:52:46 -0400
X-MC-Unique: FBTR2d-9OuiEfuNvpw0wYA-1
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-6686a103a8cso4784648b3a.1
        for <fstests@vger.kernel.org>; Wed, 28 Jun 2023 01:52:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687942365; x=1690534365;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lMefUSJfK9VBdCYF+2+lrwTVUlwXDm4Z+5YHx5byeoY=;
        b=jKoqqNAjmSag2YWlWn9BDcjpApRoyzcr2OqoqAEo3YJXITeyj9eVfU+Wa9uBvO8psb
         8h5LqmOmMQKosYMqxvi72hE5RLjr53gzT7qjJVQjPO8iBHrFoPnOMLbzHmJyJQYfSfNW
         GyFGaokMiTEEWjKFhRlrGyxmna/7DQyMIvPJ9gLgNuC78ZDfpL6YyZkpZhf2E+NNrdRs
         vr34tW15sHoMY8KYNj5a8NKBsQXY3nJBUmsLj4SjqiPOFE5ecImKqhPHu5ovvt38pWO5
         a3Esl/HO9wbq9FtJvPHAhFIdghDuY47b20jy+KWZyB+OWckyf53WMxsOv2SQ7vzaJZzO
         8g7A==
X-Gm-Message-State: AC+VfDzc6ylwtI0QTdGv9PI3TVZ2P1o5sHgrxGh5e3l1rxbfFZCKDd6s
        VnyfRwHSe3LyJkcG26+ZY9sQFGnzvo1E/dVVGnEXw8keK7Bv4wMmG1fgYBbscAqkVGs7niXRZg1
        PZqXakfLFwW9QuujFNnvEA/S+foq2
X-Received: by 2002:a05:6a00:3a26:b0:668:97bf:5ed7 with SMTP id fj38-20020a056a003a2600b0066897bf5ed7mr29209291pfb.22.1687942365421;
        Wed, 28 Jun 2023 01:52:45 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ54h9gc3D1iv1oSmBn8vH1cMJNlUBcxY1TVX0jT5LQcdO4zvAhwqNfbqvSHFvN5VJgxMKIeXA==
X-Received: by 2002:a05:6a00:3a26:b0:668:97bf:5ed7 with SMTP id fj38-20020a056a003a2600b0066897bf5ed7mr29209284pfb.22.1687942365125;
        Wed, 28 Jun 2023 01:52:45 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id n24-20020a62e518000000b006658d86f1bfsm6603134pff.53.2023.06.28.01.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 01:52:44 -0700 (PDT)
Date:   Wed, 28 Jun 2023 16:52:41 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Stas Sergeev <stsp2@yandex.ru>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] support busybox modprobe
Message-ID: <20230628085241.olv63wqya2tcej6o@zlang-mailbox>
References: <20230627182731.3428042-1-stsp2@yandex.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230627182731.3428042-1-stsp2@yandex.ru>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Jun 27, 2023 at 11:27:31PM +0500, Stas Sergeev wrote:
> This modprobe writes help to stderr.
> We need to redirect it to stdout, or it will end up in a test results.

Which modprobe version writes help to stderr, can you show more details?
Due to from my testing:

# modprobe --help >/dev/null
# modprobe --help 2>/dev/null
Usage:
        modprobe [options] [-i] [-b] modulename
        modprobe [options] -a [-i] [-b] modulename [modulename...]
        modprobe [options] -r [-i] modulename
        modprobe [options] -r -a [-i] modulename [modulename...]
        modprobe [options] -c
        modprobe [options] --dump-modversions filename
Management Options:
        -a, --all                   Consider every non-argument to
....
...

> 
> Signed-off-by: Stas Sergeev <stsp2@yandex.ru>
> ---
>  common/config | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/common/config b/common/config
> index e479df8d..936ac225 100644
> --- a/common/config
> +++ b/common/config
> @@ -261,7 +261,7 @@ export UDEV_SETTLE_PROG
>  # Set MODPROBE_PATIENT_RM_TIMEOUT_SECONDS to "forever" if you want the patient
>  # modprobe removal to run forever trying to remove a module.
>  MODPROBE_REMOVE_PATIENT=""
> -modprobe --help >& /dev/null && modprobe --help | grep -q -1 "remove-patiently"
> +modprobe --help >& /dev/null && modprobe --help 2>&1 | grep -q -1 "remove-patiently"
>  if [[ $? -ne 0 ]]; then
>  	if [[ -z "$MODPROBE_PATIENT_RM_TIMEOUT_SECONDS" ]]; then
>  		# We will open code our own implementation of patient module
> -- 
> 2.39.2
> 

