Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88D39C6FA82
	for <linux-fstests@archiver.kernel.org>; Thu, 22 Sep 2022 14:46:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbiIVOqT (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 22 Sep 2022 10:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbiIVOqS (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 22 Sep 2022 10:46:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A08D4EFF78
        for <fstests@vger.kernel.org>; Thu, 22 Sep 2022 07:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663857976;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hK8OkEI13YlbZtz/gy30d7umxiu2huJuyfljlK4FQnk=;
        b=HwFPxL3sf9rv124ilMtiVOxlmlDI2Qj/SGtdIlMx9fGZvXbx3EYsi4PF2+YocsCqwUNjT/
        gX4vvSOevS/thXtnmbFME0OhZdOfulPViRS112SYlOXb37eOQObXLGOIeZ1TclxL5UcGaN
        SsoItGWYjQsKwMu1UwbxVWIVewAhHTY=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-652-Wks6zyuFMq6oo45j9V8T4A-1; Thu, 22 Sep 2022 10:46:13 -0400
X-MC-Unique: Wks6zyuFMq6oo45j9V8T4A-1
Received: by mail-qt1-f198.google.com with SMTP id fz10-20020a05622a5a8a00b0035ce18717daso6515899qtb.11
        for <fstests@vger.kernel.org>; Thu, 22 Sep 2022 07:46:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=hK8OkEI13YlbZtz/gy30d7umxiu2huJuyfljlK4FQnk=;
        b=57nScs1F+4dyp7jM6AptkMnXoY5KQ7ITULA+wzP+lJjchmH3edWiq4YcG6WYfLiDJG
         R4TugH8tw9jI570hQ+K/eAhH1XFarY38r3q0YU67I8T8xGdFtZcA4YCT1jHSKWioFtg9
         69lJCmoiceuDtpafVS1xwPvHjiZX+TY+5hGXRvIvqoxCkKV7NyagLto4Lb6ZAVU4edVs
         p5muUAL+7BZb0iqh6MShrdSmIvMKG3MLcC1XYtE7CJrLneTsselzbxiEK1YHd8YWsH0N
         UA5EzD6MODdfGySN5ULIqAVHYPRsbtEUHnQ6LPKpZIdu226CSl4Hp6cfCFDpwO+zAISD
         MgYw==
X-Gm-Message-State: ACrzQf1dqHkdOSa0YPw9YrgwCeIIGfAAqBFjOw39IkV3ywvC86xRLvTQ
        gfMvV4cxahpyIK30ZM2QxKAwb1RVHhVOXxL/FNbAhUIGKyHHhnTTJxT28AtWQBE56DMq7F65RQd
        OJPGc0KhW/Fi75qv2yw==
X-Received: by 2002:a05:6214:4112:b0:4ac:6d95:1037 with SMTP id kc18-20020a056214411200b004ac6d951037mr2839872qvb.14.1663857971357;
        Thu, 22 Sep 2022 07:46:11 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM53o3SlOHx3Zvy78iJLgK6SYivPzWgezmCEKJjogFy5a8aAuXp5iupYiEy0MCYbX99PKN23AA==
X-Received: by 2002:a05:6214:4112:b0:4ac:6d95:1037 with SMTP id kc18-20020a056214411200b004ac6d951037mr2839861qvb.14.1663857971114;
        Thu, 22 Sep 2022 07:46:11 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id t14-20020a05620a450e00b006cbcdc6efedsm3997141qkp.41.2022.09.22.07.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 07:46:10 -0700 (PDT)
Date:   Thu, 22 Sep 2022 22:46:06 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Pavel Reichl <preichl@redhat.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH 1/4] common: Fix file leak in _get_max_file_size
Message-ID: <20220922144606.6nx5figsoe6j7wrz@zlang-mailbox>
References: <20220922134822.1020119-1-preichl@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220922134822.1020119-1-preichl@redhat.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Sep 22, 2022 at 03:48:19PM +0200, Pavel Reichl wrote:
> This is obviously mostly problematic for FS lacking support for sparse
> files.
> 
> Signed-off-by: Pavel Reichl <preichl@redhat.com>
> ---
>  common/rc         | 1 +
>  tests/generic/692 | 0
>  2 files changed, 1 insertion(+)
>  mode change 100644 => 100755 tests/generic/692
> 
> diff --git a/common/rc b/common/rc
> index 228fcb37..c9078649 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -4637,6 +4637,7 @@ _get_max_file_size()
>  			l=$m
>  		fi
>  	done
> +	rm -f $testfile

OK, as "truncate" will allocate real space in exfat and other fs not
support sparse file, I think we'd better to remove it. If you find
more similar situation, please remove them in same one patch :)

>  	echo $l
>  }
>  
> diff --git a/tests/generic/692 b/tests/generic/692
> old mode 100644
> new mode 100755

Hmm... is this another fix? Although I don't know if it's worth to be a single
patch, if it doesn't cause anything wrong?

Thanks,
Zorro

> -- 
> 2.37.3
> 

