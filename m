Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 562C1C54EE9
	for <linux-fstests@archiver.kernel.org>; Tue, 20 Sep 2022 15:03:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbiITPD0 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 20 Sep 2022 11:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231225AbiITPDY (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 20 Sep 2022 11:03:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD8231ECF
        for <fstests@vger.kernel.org>; Tue, 20 Sep 2022 08:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663686203;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=W0DpEIeHJCuewygKIrlPqYbyi21q4OGCaBM9lw/6aq0=;
        b=U5sjorcZtoUfy596t1UxdUZ0PPmdCK8UuVZUqsZUtou6pjS92+hrEsfOumHmmj/EmCgDbh
        c/EM8K6oFwfj4LGlKPNrXfW4Hq3ADTAP28bfEcNQHvu7e7yCBZBBsAXIvWTAbQURNIYRTj
        1C/pwTxitXSZ4A094FsI1IHAYJsV8wM=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-454-6RwYB1wCMAWCOLNNy-cr6g-1; Tue, 20 Sep 2022 11:03:21 -0400
X-MC-Unique: 6RwYB1wCMAWCOLNNy-cr6g-1
Received: by mail-qk1-f200.google.com with SMTP id h7-20020a05620a400700b006cebec84734so2134086qko.23
        for <fstests@vger.kernel.org>; Tue, 20 Sep 2022 08:03:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=W0DpEIeHJCuewygKIrlPqYbyi21q4OGCaBM9lw/6aq0=;
        b=C0QmBJPfVu/92KYqpSAkW+w0Xn3cNxaShXUaOVR0PLUYnitsz5ECt+8rPGQq79XklL
         SCcOvrpCY5+xlStFeHzFNkMmRh8nFg0u2THyFs41Fxmv/juGIW4lsePvRjaqLeCJS202
         CgqR9oBBECe/qzBu7MgglMrMwxBNuXosc2tsOP4vvx+7/C2KJEiIygGGJQzDUOHljW4F
         HeyfZxq7eRFhxDdcF9oFPblxYPnG7GETnyqR6uYVNiJAjzjx77PrDcQbRXLliZqMnK5K
         SXy4Zf9XmsPkg2ZYoJ76H6VdnHQuaLNGh7qArgN0wruD6y6B0mc36BubKAih5Nsn8y0J
         o5SQ==
X-Gm-Message-State: ACrzQf095CzI/NxjZHKst53sJHF2NedDqa9IZUKHd6PeCl3K8g2yyPSS
        rjB/QkiGCXCvClqiFg5n55vbHh906ozkrpnbk1KytuZmKYxmfLJM5DPdo2u60EYbTiqPPDzvqA9
        mGPvoGbiewlUE5OUnsA==
X-Received: by 2002:ad4:5dc8:0:b0:4ac:7fff:4360 with SMTP id m8-20020ad45dc8000000b004ac7fff4360mr18902933qvh.69.1663686201015;
        Tue, 20 Sep 2022 08:03:21 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4ynKdaA8GnSAgXPG02Erk+nH92CpNCh0TR3TFjsNqrg+ZaIoSP/UKHpTRP0vNvlJcNCbferA==
X-Received: by 2002:ad4:5dc8:0:b0:4ac:7fff:4360 with SMTP id m8-20020ad45dc8000000b004ac7fff4360mr18902894qvh.69.1663686200688;
        Tue, 20 Sep 2022 08:03:20 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id l16-20020ac87250000000b0035bb6298526sm115690qtp.17.2022.09.20.08.03.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 08:03:20 -0700 (PDT)
Date:   Tue, 20 Sep 2022 23:03:15 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Pavel Reichl <preichl@redhat.com>
Cc:     fstests@vger.kernel.org, djwong@kernel.org
Subject: Re: [PATCH v3 1/2] common: new helper to alloacate fixed size files
Message-ID: <20220920150315.ewt64nqcwfyueyjs@zlang-mailbox>
References: <20220920073514.285136-1-preichl@redhat.com>
 <20220920073514.285136-2-preichl@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220920073514.285136-2-preichl@redhat.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Sep 20, 2022 at 09:35:13AM +0200, Pavel Reichl wrote:
> Helper that creates files of specified size using falloc if supported,
> otherwise pwrite is used.
> 
> Signed-off-by: Pavel Reichl <preichl@redhat.com>
> ---
>  common/rc         | 13 +++++++++++++
>  tests/generic/694 |  2 +-
>  2 files changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/common/rc b/common/rc
> index a25cbcd0..77866582 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -4925,6 +4925,19 @@ hexdump()
>  	_fail "Use _hexdump(), please!"
>  }
>  
> +# Helper to write a file containing specified number of bytes using
> +# falloc if supported, otherwise use pwrite
> +_create_sizedfile()
> +{
> +	length=$1
> +	file=$2
> +
> +	$XFS_IO_PROG -F -fc "falloc 0 $length" $file 2>&1 | grep -q "Operation not supported"

Do we need to make sure if the $file really get $length space, due to if might
fail but not due to "Operation not supported", e.g. ENOSPC or others.

> +	if [ $? -eq 0 ]; then
> +		$XFS_IO_PROG -F -fc "pwrite -W 0 $length" $file >/dev/null
> +	fi

Another question I'm thinking is do we need "-t" to make sure the $file isn't
bigger than what we want. And do we need to truncate the file to $length, to
make sure fs doesn't allocate more space?

Thanks,
Zorro

> +}
> +
>  init_rc
>  
>  ################################################################################
> diff --git a/tests/generic/694 b/tests/generic/694
> index dfd988df..64c3dd9a 100755
> --- a/tests/generic/694
> +++ b/tests/generic/694
> @@ -30,7 +30,7 @@ junk_dir=$TEST_DIR/$seq
>  junk_file=$junk_dir/junk
>  mkdir -p $junk_dir
>  
> -$XFS_IO_PROG -f -c "pwrite -W 0 4G" $junk_file > /dev/null
> +_create_sizedfile 4G $junk_file
>  
>  iblocks=`stat -c '%b' $junk_file`
>  
> -- 
> 2.37.3
> 

