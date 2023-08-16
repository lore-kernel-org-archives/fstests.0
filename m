Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30C62C04E69
	for <linux-fstests@archiver.kernel.org>; Wed, 16 Aug 2023 14:57:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237710AbjHPO44 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 16 Aug 2023 10:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343889AbjHPO4j (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 16 Aug 2023 10:56:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFC65269F
        for <fstests@vger.kernel.org>; Wed, 16 Aug 2023 07:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692197750;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=c1EX79ul9VWQSAUfFqeaBN66e4RVjGsWSXMpBY6MlI8=;
        b=AtNZxLe2DVsHhS0iVwmG9VW82PoWos2ENayglG8gYMDYi6UKhQBuq89Xb/1bbx3ebtcjWg
        hFJlT9lls8Z+/ObdlVOgOr/O4XrQasCjw1GlRa/npgdeTzHVjORRDpLC++VUAiI4mXBBcy
        ArI6xM6oIpe4zBthBHeE9GImfiHNNpY=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-235-1D4DVmMIN8GkwX3OCT1jmg-1; Wed, 16 Aug 2023 10:55:48 -0400
X-MC-Unique: 1D4DVmMIN8GkwX3OCT1jmg-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1bdeadd1b0cso33249315ad.1
        for <fstests@vger.kernel.org>; Wed, 16 Aug 2023 07:55:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692197747; x=1692802547;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c1EX79ul9VWQSAUfFqeaBN66e4RVjGsWSXMpBY6MlI8=;
        b=TUQHFF930NRpseGweSn0M78v/y74UmB2t2bgyVUrWsEU3wFcMh8CESsO2pHaPCHrG8
         QZnv2TCFesCpgRqh5IR+ldgcyETXFmBwMunPKYljKhhaTCwWwqKCIHurHJI3ubUWq7l8
         gGTYlqOHEsnerhwK0eGYT9nrCY+4dTUY9Dh6Z/zEzJA36tZL4ijTiGoVqSh9/mBtAFnm
         +Zw1oJndHhCjEFWTeAF2cpeYztes9LH8sPqLE9RJqQEA7wsP7jXgrmP096VQ1u8KPO+1
         WB4vES6V1a+lzpoqs29v2NRrih4XNbKE/RCzP/vpHP4lRU1u4+bIbHpsPuczpJA8bn+U
         Azuw==
X-Gm-Message-State: AOJu0YzDYvUe92q3qHmhMRCTXEa/gjXgngQWiQgUK3AzzOdEWgtWtYuB
        oj6ljM0b5TMdXnOBbcJ3whk3CcDTOdf19Ibq2QbvXl9RhtVdTHk0IJogjcQlixWmp8v0Oly3r3r
        jCYoufEvSj8zf8bspznJ4E2FIcUNqUuU=
X-Received: by 2002:a17:903:26c5:b0:1bd:afd6:e808 with SMTP id jg5-20020a17090326c500b001bdafd6e808mr1881011plb.26.1692197747437;
        Wed, 16 Aug 2023 07:55:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0P07atLfEfaAgGlwJatwPdIq1p+RS3fNj/KiWyK7s/QdpjD/+CZX3YEmRE/eUVB6NnA5l3g==
X-Received: by 2002:a17:903:26c5:b0:1bd:afd6:e808 with SMTP id jg5-20020a17090326c500b001bdafd6e808mr1880996plb.26.1692197747031;
        Wed, 16 Aug 2023 07:55:47 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id p5-20020a170902eac500b001b9be3b94d3sm2386755pld.140.2023.08.16.07.55.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 07:55:46 -0700 (PDT)
Date:   Wed, 16 Aug 2023 22:55:43 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     David Disseldorp <ddiss@suse.de>
Cc:     fstests@vger.kernel.org, Anand Jain <anand.jain@oracle.com>
Subject: Re: [PATCH v2] common/rc: drop 'fsck -f' parameter from
 _repair_test_fs
Message-ID: <20230816145543.ic73cnwhzayuivag@zlang-mailbox>
References: <20230816103330.961-1-ddiss@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230816103330.961-1-ddiss@suse.de>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Aug 16, 2023 at 12:33:30PM +0200, David Disseldorp wrote:
> The '-f' parameter is fsck.ext# specific, where it's documented to:
>   Force checking even if filesystem is marked clean
> 
> _repair_test_fs() is only called on _check_test_fs() failure, so
> dropping the parameter should be possible without changing ext#
> behaviour.
> Doing so fixes _repair_test_fs() on exfat, where fsck.exfat doesn't
> support '-f'.
> 
> Signed-off-by: David Disseldorp <ddiss@suse.de>
> ---
> v2: drop -f from default case instead of splitting out exfat case

This version is good to me.

Reviewed-by: Zorro Lang <zlang@redhat.com>

I remembered you hope to add a btrfs branch to _repair_scratch_fs and
_repair_test_fs [1]. Is that still in your plan? Anand, could you provide
more suggestions about that?

[1]
https://lore.kernel.org/fstests/20230808091454.4skdyjnaxjqa7zyi@zlang-mailbox/

> 
>  common/rc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/common/rc b/common/rc
> index 5c4429ed..66d270ac 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -1231,7 +1231,7 @@ _repair_test_fs()
>  		;;
>  	*)
>  		# Let's hope fsck -y suffices...
> -		fsck -t $FSTYP -fy $TEST_DEV >$tmp.repair 2>&1
> +		fsck -t $FSTYP -y $TEST_DEV >$tmp.repair 2>&1
>  		res=$?
>  		if test "$res" -lt 4 ; then
>  			res=0
> -- 
> 2.35.3
> 

