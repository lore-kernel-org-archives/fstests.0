Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3651AC001DB
	for <linux-fstests@archiver.kernel.org>; Mon,  7 Aug 2023 17:49:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbjHGRtb (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 7 Aug 2023 13:49:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjHGRta (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 7 Aug 2023 13:49:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D38172C
        for <fstests@vger.kernel.org>; Mon,  7 Aug 2023 10:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691430522;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7c8JZ1QBgIq3H57/Xs2jbZ4oT4tiAWgA+cNSuJzXR88=;
        b=JEd8BbuFQ7tvEOdEyYClHPGMYOqtto6j0e1OTfoSk6mlfNfey55FYC0JH1GTFg/pODUSdt
        VhDjA6cEvBXrxaMY3SVf154qyqpmyXpuux4KUN4lc+TZ9wvp24OqqcwyuXCmr5X5YZdHTF
        CSNm97HYDaFt4YAmRY9yBoPL560r7rw=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-133-nKMmZQWSNfOiVSWbewj5HA-1; Mon, 07 Aug 2023 13:48:40 -0400
X-MC-Unique: nKMmZQWSNfOiVSWbewj5HA-1
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-56357814339so2920109a12.3
        for <fstests@vger.kernel.org>; Mon, 07 Aug 2023 10:48:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691430519; x=1692035319;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7c8JZ1QBgIq3H57/Xs2jbZ4oT4tiAWgA+cNSuJzXR88=;
        b=Xof/KHmZCYU36LA/sumDFlEPN4qTWtqdqNzgYQTS70Yh2WY7DBdBUyfh0+2b9N8Nxg
         NuNTRLSWgTckKIRo3F3QI5xD0pxHYbS+tYrlEEjuMeC0XjoZRCj/sRs19rr+kJdw7RV9
         xxq6QphQ8GP+veRAA/D5dcNJtIyZ67eSmtqHt6Jj0Aw+BNU9jtEPc4hYJYKkItMFv1Zd
         uKxzT624PJmZV8QtyFbf2aSVVSuAbnBQ50VYiCD0HcpCbQoaI7yNwOU211Z6l8fTH5lz
         VSezwVfouIj2pnS3VFwRtN/3lFRpiKlAoicV+oVkji2ouJfAhU5KWO77Svac61jp1m4a
         mrkg==
X-Gm-Message-State: AOJu0YxQ7oTLwYj47uPIKjrp4U0yyUAwCHlrFnFGr7FVuL2cyUy6CskN
        fYaqxOrAyCV6/BYlkF5KZzyjRB11g/LJVy3jQ/khQtEuObborVU0GmmjTIHsMXzmTqi4ZGhDuK7
        uJjWr04fZ2OWlp+sdyA==
X-Received: by 2002:a05:6a20:549f:b0:133:fd64:8d48 with SMTP id i31-20020a056a20549f00b00133fd648d48mr10101868pzk.4.1691430519496;
        Mon, 07 Aug 2023 10:48:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQD/IRSA0BmC+SG8GTJalo5Xx4bxLNTvarhdhW5SHobNefMSnBch0OwIgYeQ/PBRwunS/RCQ==
X-Received: by 2002:a05:6a20:549f:b0:133:fd64:8d48 with SMTP id i31-20020a056a20549f00b00133fd648d48mr10101851pzk.4.1691430519190;
        Mon, 07 Aug 2023 10:48:39 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id f26-20020aa782da000000b00682b2fbd20fsm6474615pfn.31.2023.08.07.10.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 10:48:38 -0700 (PDT)
Date:   Tue, 8 Aug 2023 01:48:35 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     David Disseldorp <ddiss@suse.de>
Cc:     fstests@vger.kernel.org, linkinjeon@kernel.org,
        sj1557.seo@samsung.com, "Darrick J. Wong" <djwong@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH] common/rc: drop '-f' parameter from fsck.exfat
Message-ID: <20230807174835.moxyuvx4mp47pvky@zlang-mailbox>
References: <20230807112850.9198-1-ddiss@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230807112850.9198-1-ddiss@suse.de>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Aug 07, 2023 at 01:28:50PM +0200, David Disseldorp wrote:
> fsck.exfat doesn't support the '-f' flag, so add a special case to
> _repair_test_fs().

I'm wondering why _repair_scratch_fs() doesn't have the '-f', but the
_repair_test_fs() has it. Looks like the '-f' option was for extN fs
originally, it's not a fsck common option, but in fsck.ext4.

So I think the '-f' might not be a necessary option. As _repair_scratch_fs
works without it, can we just remove the '-f' from _repair_test_fs()?

As _repair_test_fs was added by Ted, and _repair_scratch_fs was added
by Darrick, so CC them to get more review -- do we real need the '-f'
or not by default :)

Thanks,
Zorro

> 
> Signed-off-by: David Disseldorp <ddiss@suse.de>
> ---
>  common/rc | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/common/rc b/common/rc
> index 5c4429ed..ac7e50f1 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -1229,6 +1229,14 @@ _repair_test_fs()
>  			res=$?
>  		fi
>  		;;
> +	exfat)
> +		# exfat doesn't support -f
> +		fsck -t $FSTYP -y $TEST_DEV >$tmp.repair 2>&1
> +		res=$?
> +		if ((res < 4)); then
> +			res=0
> +		fi
> +		;;
>  	*)
>  		# Let's hope fsck -y suffices...
>  		fsck -t $FSTYP -fy $TEST_DEV >$tmp.repair 2>&1
> -- 
> 2.35.3
> 

