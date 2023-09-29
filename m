Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80762E743E1
	for <linux-fstests@archiver.kernel.org>; Fri, 29 Sep 2023 05:18:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232519AbjI2FSX (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 29 Sep 2023 01:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232537AbjI2FSW (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 29 Sep 2023 01:18:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53175195
        for <fstests@vger.kernel.org>; Thu, 28 Sep 2023 22:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695964653;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qNzIK+hDRSEvCljzH+3cTf/shuxMZGWWu5JeZVomWdg=;
        b=fnVnBYlLWERRfz4L2XkXe5yDpxyD/MujWKcKJfViUsltRgeb8iqAONpIdk333QWvJioKDs
        qbaRm7YECMJfZdimO1bXmNj8uay72ckH+fbeyuuGTgUcL2UuLvBNLd2kokIPbeCxugrR9H
        hNUuKtBy4X61eVBlR4eGUXvOYftNnSg=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-LcjdL-ybO-CXhS26LlLx2w-1; Fri, 29 Sep 2023 01:17:25 -0400
X-MC-Unique: LcjdL-ybO-CXhS26LlLx2w-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-278f5b7a960so5645929a91.2
        for <fstests@vger.kernel.org>; Thu, 28 Sep 2023 22:17:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695964644; x=1696569444;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qNzIK+hDRSEvCljzH+3cTf/shuxMZGWWu5JeZVomWdg=;
        b=iXFvabpZIqwg8zpD5DCE3Hct4ZuVqp3fNMIIKkqvs7bgDL5Z6CT621bOXUCVIq7yP5
         KWIyKMDD1DiNc9oT+zzD5wWigiQ5mBwbshBRCWlcSu9lkhNaFFxfjDezELFcj4Um6FEf
         B1P7ns2slyEBDjxIOlgk3K6sGHBr/AV0uAs+5UbXMrTI9E5GDc2RL8C12pKnR67KJfFv
         2pMbs2vti2iolw1IPwcnSRjXYb3ndqm4Pt6RiYAZITP8XWArlBr4xtaIePKeqbO2ATAp
         39uaC5IgA1jdq2hZn8D/oYWXsxNb6dWJmQDIAyy7QeyI3NvOxYzok+4ooSBhe2yT1jML
         zwKA==
X-Gm-Message-State: AOJu0YxhbAAIBr+op7wmSngEQIwMob+GPSinp66mxDIfj12wFWgmCBAS
        Y5iwfRHA8eltdSbpQKAz3flJOFsAQct5rWwPbEZI6W/yjSj0qGrL3Nh+GYYbFYLt4fIt72/tvNU
        2+i2wtIHApOs9ZNXAog==
X-Received: by 2002:a17:90a:64f:b0:279:104e:1779 with SMTP id q15-20020a17090a064f00b00279104e1779mr3160690pje.16.1695964643980;
        Thu, 28 Sep 2023 22:17:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrtP3sbKcO75m2H368iUYaattz5g53Z+pHQ2t4QlCntswaEZ2FZpjjT6rGSMYPs6pyCRw3DA==
X-Received: by 2002:a17:90a:64f:b0:279:104e:1779 with SMTP id q15-20020a17090a064f00b00279104e1779mr3160681pje.16.1695964643625;
        Thu, 28 Sep 2023 22:17:23 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id ge13-20020a17090b0e0d00b002680dfd368dsm482248pjb.51.2023.09.28.22.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 22:17:23 -0700 (PDT)
Date:   Fri, 29 Sep 2023 13:17:20 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-xfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH 1/1] xfs/018: make sure that larp mode actually works
Message-ID: <20230929051720.naai64pxwrxbbjdr@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <169567816120.2269819.5620379594030200785.stgit@frogsfrogsfrogs>
 <169567816694.2269819.8230834804621611518.stgit@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <169567816694.2269819.8230834804621611518.stgit@frogsfrogsfrogs>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Sep 25, 2023 at 02:42:46PM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Skip this test if larp mode doesn't work.
> 
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---
>  tests/xfs/018 |   13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> 
> diff --git a/tests/xfs/018 b/tests/xfs/018
> index 1ef51a2e61..73040edc92 100755
> --- a/tests/xfs/018
> +++ b/tests/xfs/018
> @@ -71,6 +71,17 @@ create_test_file()
>  	done
>  }
>  
> +require_larp()
> +{
> +	touch $SCRATCH_MNT/a
> +
> +	# Set attribute, being careful not to include the trailing newline
> +	# in the attr value.
> +	echo -n "attr_value" | ${ATTR_PROG} -s "attr_name" $SCRATCH_MNT/a 2>&1 | \
> +		grep 'Operation not supported' && \
> +		_notrun 'LARP not supported on this filesystem'

"rm -f $SCRATCH_MNT/a" ? although that's not necessary :)

Reviewed-by: Zorro Lang <zlang@redhat.com>

> +}
> +
>  # real QA test starts here
>  _supported_fs xfs
>  
> @@ -112,6 +123,8 @@ _scratch_mount
>  testdir=$SCRATCH_MNT/testdir
>  mkdir $testdir
>  
> +require_larp
> +
>  # empty, inline
>  create_test_file empty_file1 0
>  test_attr_replay empty_file1 "attr_name" $attr64 "s" "larp"
> 

