Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33208C433EF
	for <linux-fstests@archiver.kernel.org>; Wed,  8 Jun 2022 04:52:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbiFHEwT (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 8 Jun 2022 00:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231529AbiFHEvx (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 8 Jun 2022 00:51:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4D1B5253FC0
        for <fstests@vger.kernel.org>; Tue,  7 Jun 2022 18:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654651049;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=slIHfG8WZ1tWaqj1MJ5t7kKpXqQTszZtJPACqYjHZNA=;
        b=YGBbc9TrCx9jlv+J3kQtAWJyiWIt2oyMYrWr02au9G+ATRpK7Uo8rDIR59XJkixBD2wSay
        9p9G8iZnkztsOhNfmVpsnitFsKuVKLgj/6GAEf+CwolDSme8egfSfT8yx0bUiretS3pUxO
        36yTPsS52zptCMmMaMOgTev82mJf59U=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-35-JhC1GacMMvy4jtPt76Xhjg-1; Tue, 07 Jun 2022 21:17:28 -0400
X-MC-Unique: JhC1GacMMvy4jtPt76Xhjg-1
Received: by mail-pf1-f198.google.com with SMTP id c191-20020a621cc8000000b0051bd765ffc5so7514903pfc.21
        for <fstests@vger.kernel.org>; Tue, 07 Jun 2022 18:17:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=slIHfG8WZ1tWaqj1MJ5t7kKpXqQTszZtJPACqYjHZNA=;
        b=eniBDVntDM4qw+pwTmnCamn8lvZ5VdnI8HFhTkBnAo9hzCP8NAqG7aF1cGa8xDgInh
         s2SCGU+Kb29XJZDnQoaZbJF5N7ZXY7eDySJCfy1DBJ3tXCkw8k0lrJ+mGua6t3bGXMpU
         OZnEsFvYXK2M9cO8MT/zr/VFV6k1hMbK9Xf/Q/Duz032tBNof/34cFCv7n8bdS1CjC0z
         fSONIBPicOK0m8aRf/kHPpH9dtp4F7Td5ZtXU2TyOJGwviy0wmOPspbw13iOcZAVTFps
         emsJJAyXzpvoPPQpGVhXO7nCoeffCevP7jd7SQstZppH2qIWXQxqdtPX1j0iv9haSkBv
         3uSQ==
X-Gm-Message-State: AOAM532+GhpnHt3btPIOahU89bvt/5W7pIa7WnYbusb3pHZRqYCepY+y
        aX2RxiVp3fU/O4WB2TPOM2SgDa1AcKgWT4Nw7P4JKoaJHViezLS6M3KPodp1xO5VVYIACizhKSk
        P+J6UsUKwWyyopPHecg==
X-Received: by 2002:a17:90b:3789:b0:1e3:459a:1202 with SMTP id mz9-20020a17090b378900b001e3459a1202mr35055601pjb.113.1654651046714;
        Tue, 07 Jun 2022 18:17:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy91FkFQWS5eg/s4cNvErfR3p00QGMIw4CuWJEyPUjL7TOYQ/5xvNgJaY6GfHMtGvmhjQa74g==
X-Received: by 2002:a17:90b:3789:b0:1e3:459a:1202 with SMTP id mz9-20020a17090b378900b001e3459a1202mr35055586pjb.113.1654651046496;
        Tue, 07 Jun 2022 18:17:26 -0700 (PDT)
Received: from [10.72.12.54] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id kw3-20020a17090b220300b001e2f6c7b6f6sm12597863pjb.10.2022.06.07.18.17.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jun 2022 18:17:25 -0700 (PDT)
Subject: Re: [PATCH v2] src/attr_replace_test: dynamically adjust the max
 xattr size
To:     =?UTF-8?Q?Lu=c3=ads_Henriques?= <lhenriques@suse.de>,
        fstests@vger.kernel.org, "Darrick J. Wong" <djwong@kernel.org>
Cc:     Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org
References: <87wnds8mxv.fsf@brahms.olymp>
 <20220607165153.27797-1-lhenriques@suse.de>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <9c21300a-e731-443f-39a0-38da3204c975@redhat.com>
Date:   Wed, 8 Jun 2022 09:17:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220607165153.27797-1-lhenriques@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


On 6/8/22 12:51 AM, Luís Henriques wrote:
> CephFS doesn't had a maximum xattr size.  Instead, it imposes a maximum size
> for the full set of xattrs names+values, which by default is 64K but may be
> changed.
>
> Test generic/486 started to fail after fixing a ceph bug where this limit
> wasn't being imposed.  Adjust dynamically the size of the xattr being set
> if the error returned is -ENOSPC.
>
> Signed-off-by: Luís Henriques <lhenriques@suse.de>
> ---
>   src/attr_replace_test.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/src/attr_replace_test.c b/src/attr_replace_test.c
> index cca8dcf8ff60..d1b92703ba2a 100644
> --- a/src/attr_replace_test.c
> +++ b/src/attr_replace_test.c
> @@ -62,7 +62,10 @@ int main(int argc, char *argv[])
>   
>   	/* Then, replace it with bigger one, forcing short form to leaf conversion. */
>   	memset(value, '1', size);
> -	ret = fsetxattr(fd, name, value, size, XATTR_REPLACE);
> +	do {
> +		ret = fsetxattr(fd, name, value, size, XATTR_REPLACE);
> +		size -= 256;

I am not sure whether will this break other filesystems tests.

Maybe we should get the filesystem type first from 'st_mode', and then 
in ceph case we should minus strlen(name) before replacing the it. And 
then if it fails with '-ENOSPC' do the following ?

Or maybe we could get maximum length of xattr from ioctl(fd) in ceph case ?


> +	} while ((ret < 0) && (errno == ENOSPC) && (size > 256));
>   	if (ret < 0) die();
>   	close(fd);
>   
>

