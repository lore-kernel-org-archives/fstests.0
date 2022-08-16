Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1271C25B0E
	for <linux-fstests@archiver.kernel.org>; Tue, 16 Aug 2022 12:28:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbiHPM17 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 16 Aug 2022 08:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiHPM16 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 16 Aug 2022 08:27:58 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF32D73924
        for <fstests@vger.kernel.org>; Tue, 16 Aug 2022 05:27:57 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id o5-20020a17090a3d4500b001ef76490983so9450991pjf.2
        for <fstests@vger.kernel.org>; Tue, 16 Aug 2022 05:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fydeos.io; s=fydeos;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=mw355Oe3kUJG8mzAKHeYOIh1fohGX5psU+5c+TYFrm4=;
        b=eeVIxincNYuljE4qIeBDsxoZU6ZzPUsTpBDOXq2EtLW52o4SCa+1irZ+hiFITFWC3G
         riDeAvMxKfvmRP3HRg6DQ78j1VvUrWMBRhXl5E2vFcd52+T+uT5CbXBDC6rSrcpE3phF
         Wv950eOw6EKl/1mD6wAYIpo0n2841USSzoUMVxMhTj4sF07tSrrY1oI2rw9d8oM7oJFo
         Il9ZQEOGo0YvJ+HjDo19OCij6P+5ZjyKV8eSO42+ahaWitnd3Eop1NdKMpGLR9Xo1swc
         UlI5tKfE/pAGLs//9gTBAmw84UpA0k/IX5VzsfnVMDUkEzXxQq+rCEEC+rnnorB4wAB7
         MBXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=mw355Oe3kUJG8mzAKHeYOIh1fohGX5psU+5c+TYFrm4=;
        b=lg92vpwobWH7MsZnZ2oEUcR0tTmpJdo7lE5DlOYaEzLG6IAWGa9LItfs5tPKWgnwQv
         eY6DSoU0XWeIdHSIoAIKz4hccxEYU9hrJ3W2N9QGmEswFz+ju5GNJOUOOYabaOKvgbYT
         s8HmuzkIAi96BjDchkBVJgPSQa5u1GttxO/0rZVdUZXu0c9oMCvmk58VsGTxEA2gmfBE
         bIjKrPIRHbWVs5RAAUd8RT2MxkF06Y/hfq4FowlHYDWrG5FRn/jbCSiK9j6Cdm4WHQrC
         EraTYHIoiFX8UKyUVB/q4rBzIa8K1Gu7Hye2yEQbGJXEbEhB8C4Os7HsfHYS6MFwb6+W
         3/BQ==
X-Gm-Message-State: ACgBeo0ckLKOgLtTNQfEF1/a9tD/nVOFGSFM5Oss5wwhsyKfec3Z5GyO
        iacrIN+a2pkVeCalmOl+a52+JYpR9SU+H/8/
X-Google-Smtp-Source: AA6agR7qXf972shU0Xlpml7vzdzMZTloXWHFbOA2vagxUJ1hqVPNIQjIZMu/oF3wAUv6kN4nEuK7qA==
X-Received: by 2002:a17:902:8642:b0:171:2632:b52f with SMTP id y2-20020a170902864200b001712632b52fmr21936083plt.59.1660652877327;
        Tue, 16 Aug 2022 05:27:57 -0700 (PDT)
Received: from [192.168.3.106] ([2403:18c0:3:bd::])
        by smtp.gmail.com with ESMTPSA id l16-20020a170902f69000b001708b189c4asm8976600plg.137.2022.08.16.05.27.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Aug 2022 05:27:56 -0700 (PDT)
Message-ID: <d7f5a9d3-4c04-dda0-ab75-0fb5d63c4fb7@fydeos.io>
Date:   Tue, 16 Aug 2022 20:27:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH] attr: validate kuid first in chown_common
Content-Language: en-US
To:     Christian Brauner <brauner@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, fstests@vger.kernel.org,
        l@damenly.su, Seth Forshee <sforshee@digitalocean.com>
References: <20220816092538.84252-1-glass@fydeos.io>
 <20220816103040.gtgg2w75tzpejas5@wittgenstein>
From:   Su Yue <glass@fydeos.io>
In-Reply-To: <20220816103040.gtgg2w75tzpejas5@wittgenstein>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org



On 2022/8/16 18:30, Christian Brauner wrote:
> On Tue, Aug 16, 2022 at 05:25:38PM +0800, Su Yue wrote:
>> Since the commit b27c82e12965 ("attr: port attribute changes to new
>> types"), chown_common stores vfs{g,u}id which converted from kuid into
>> iattr::vfs{g,u}id without check of the corresponding fs mapping ids.
>>
>> When fchownat(2) is called with unmapped {g,u}id, now chown_common
>> fails later by vfsuid_has_fsmapping in notify_change. Then it returns
>> EOVERFLOW instead of EINVAL to the caller.
>>
>> Fix it by validating k{u,g}id whether has valid fs mapping ids in
>> chown_common so it can return EINVAL early and make fchownat(2)
>> behave consistently.
>>
>> This commit fixes fstests/generic/656.
>>
>> Cc: Christian Brauner (Microsoft) <brauner@kernel.org>
>> Cc: Seth Forshee <sforshee@digitalocean.com>
>> Fixes: b27c82e12965 ("attr: port attribute changes to new types")
>> Signed-off-by: Su Yue <glass@fydeos.io>
>> ---
> 
> Thanks for the patch, Su!
> 
Thanks for you quick rely.

> I'm aware of this change in behavior and it is intentional. The
> regression risk outside of fstests is very low. So I would prefer if we
> fix the test in fstests first to check for EINVAL or EOVERFLOW.
> 

Agreed. If the errno value is intentional then a fix of fstests case is
the right.

> The reason is that reporting EOVERFLOW for this case is the correct
> behavior imho:
> 
> - EINVAL should only be reported because the target {g,u}id_t has no
>    mapping in the caller's idmapping, i.e. doesn't yield a valid k{g,u}id_t.
> - EOVERFLOW should be reported because the target k{g,u}id_t doesn't
>    have a mapping in the filesystem idmapping or mount idmapping. IOW,
>    the filesystem cannot represent the intended value. The mount's
>    idmapping is on a par with the filesystem idmapping and thus a failure
>    to represent a vfs{g,u}id_t in the filesystem should yield EOVERFLOW.
> 
As your detailed explanation, EOVERFLOW should be aware of in real word.
Would you like to send a patch to add the above segement to man page of
fchownat(2). EOVERFLOW confused me when I first got the errno.


> Would you care to send something like the following:
> 

Just sent it.

--
Su
> diff --git a/src/vfs/idmapped-mounts.c b/src/vfs/idmapped-mounts.c
> index 63297d5f..ee41110f 100644
> --- a/src/vfs/idmapped-mounts.c
> +++ b/src/vfs/idmapped-mounts.c
> @@ -7367,7 +7367,7 @@ static int setattr_fix_968219708108(const struct vfstest_info *info)
>                   */
>                  if (!fchownat(open_tree_fd, FILE1, 0, 0, AT_SYMLINK_NOFOLLOW))
>                          die("failure: change ownership");
> -               if (errno != EINVAL)
> +               if (errno != EINVAL && errno != EOVERFLOW)
>                          die("failure: errno");
> 
>                  /*
> @@ -7457,7 +7457,7 @@ static int setattr_fix_968219708108(const struct vfstest_info *info)
>                   */
>                  if (!fchownat(open_tree_fd, FILE1, 0, 0, AT_SYMLINK_NOFOLLOW))
>                          die("failure: change ownership");
> -               if (errno != EINVAL)
> +               if (errno != EINVAL && errno != EOVERFLOW)
>                          die("failure: errno");
> 
>                  /*
> 
> to fstests upstream?
