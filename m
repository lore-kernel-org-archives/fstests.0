Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF198C6FA82
	for <linux-fstests@archiver.kernel.org>; Thu, 22 Sep 2022 14:05:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbiIVOFO (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 22 Sep 2022 10:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbiIVOFL (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 22 Sep 2022 10:05:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 720A5A99F5
        for <fstests@vger.kernel.org>; Thu, 22 Sep 2022 07:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663855508;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vt16du8YjTKc4ZsRrYpWhSrbxclyD6u2MeMil614VHk=;
        b=E3otPR32UFZy1KpkPUSA7xvD9rjzyWoc0b61HVGenFZSHcYgVlWtYWLxaM+AM+dFrToEsQ
        sj5sfJVXlYkxvdqI0t4Gn8wSlWMDj7nWVnFd6ghwqOtrKbfM0cqQY+jKZBQoz/7glytXmr
        joUUoFsWI2Ug15BUeMgdL7BB4IRuq7w=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-145-gW8FB1dBNY2hETjOKSjPnQ-1; Thu, 22 Sep 2022 10:05:07 -0400
X-MC-Unique: gW8FB1dBNY2hETjOKSjPnQ-1
Received: by mail-qk1-f198.google.com with SMTP id n15-20020a05620a294f00b006b5768a0ed0so6622015qkp.7
        for <fstests@vger.kernel.org>; Thu, 22 Sep 2022 07:05:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=vt16du8YjTKc4ZsRrYpWhSrbxclyD6u2MeMil614VHk=;
        b=sgnBgPVXFEwMvMLq6HuSaoteGho5W7jYU+6KymhNP/CVpjnnZJsvqtrlIgwAV2RD+n
         KWvBpX+9UYLDMyBdA99EUsWGrt6gXfMyiHDL7JkID9RtXcnQcVSvOs3jARxTEER6Br8j
         /+dwzHLzjD9/EpIg3+eD3muHBkhuVHR8FkTdL9YENkTKUH/PFWdQczu6ayFWS9Z56HOH
         hM6U0cApgAunfcO9GR8pxmgTdVGvNJJCxnhfFtUixVSthfU707huQAdFV6B2udyoQ3cR
         TQMlaA7iPujOXA5sotLs9kuCSLiMpV01D7mI85MMrHpcl9AWNyvq9x/aOK/93syw28De
         KozA==
X-Gm-Message-State: ACrzQf20NQ0szUBofvdcI5zfJLM85yHfl2V1E8TpU4Wu0yyuYMPyR6Zg
        qrlUoX/ulHrGDjdxrUbMLkei0GHFJNKoHECq9Se4psSiKCj7KwUfQJ1kYqS2FLpipV1DLy3L/SY
        Ea/u6xoDrfDo7P2KP9Q==
X-Received: by 2002:ac8:5b44:0:b0:35b:b23b:2f2c with SMTP id n4-20020ac85b44000000b0035bb23b2f2cmr2888846qtw.133.1663855507096;
        Thu, 22 Sep 2022 07:05:07 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4ZyOKA/UcLaAkQIHsgNaqjwUzjbFaoOXwIkOqMRWHYrDfNnEGYfRhl5qpp9f8T9BeydAPbvg==
X-Received: by 2002:ac8:5b44:0:b0:35b:b23b:2f2c with SMTP id n4-20020ac85b44000000b0035bb23b2f2cmr2888799qtw.133.1663855506676;
        Thu, 22 Sep 2022 07:05:06 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id x17-20020a05620a449100b006b9264191b5sm4006497qkp.32.2022.09.22.07.05.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 07:05:06 -0700 (PDT)
Date:   Thu, 22 Sep 2022 22:05:01 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Pavel Reichl <preichl@redhat.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v5 1/2] common: new helper to alloacate fixed size files
Message-ID: <20220922140501.fo5b73eipp333euy@zlang-mailbox>
References: <20220922063836.974796-1-preichl@redhat.com>
 <20220922063836.974796-2-preichl@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220922063836.974796-2-preichl@redhat.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Sep 22, 2022 at 08:38:35AM +0200, Pavel Reichl wrote:
> Helper that creates files of specified size using falloc if supported,
> otherwise pwrite is used.
> 
> Signed-off-by: Pavel Reichl <preichl@redhat.com>
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> ---
>  common/rc         | 23 +++++++++++++++++++++++
>  tests/generic/694 |  8 +++++++-
>  2 files changed, 30 insertions(+), 1 deletion(-)
> 
> diff --git a/common/rc b/common/rc
> index a25cbcd0..228fcb37 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -4925,6 +4925,29 @@ hexdump()
>  	_fail "Use _hexdump(), please!"
>  }
>  
> +# Try to create a file with inode->i_blocks >= (length / blocksize).
> +# There may be some small overhead, e.g. ext2 filesystem allocates a
> +# substantial number of blocks to store block mappings. Those are accounted
> +# to i_blocks.
> +_create_file_sized()
> +{
> +	local length=$1
> +	local file=$2
> +	local tmp=`mktemp -u`
> +	local ret=0
> +
> +	$XFS_IO_PROG -ft -c "falloc 0 $length" $file >$tmp.out 2>&1
> +	ret=$?
> +	if (grep -Eq "Operation not supported|command .* not found" $tmp.out);then
> +		# fallocate isn't supported, fallback to general buffer write
> +		$XFS_IO_PROG -ft -c "pwrite 0 $length" $file >$tmp.out 2>&1
> +		ret=$?
> +	fi
> +	[ $ret -ne 0 ] && cat $tmp.out
> +	rm -f $tmp.out
> +	return $ret
> +}
> +
>  init_rc
>  
>  ################################################################################
> diff --git a/tests/generic/694 b/tests/generic/694
> index dfd988df..c96c2154 100755
> --- a/tests/generic/694
> +++ b/tests/generic/694
> @@ -21,6 +21,9 @@ _cleanup()
>  }
>  
>  _supported_fs generic
> +_fixed_by_kernel_commit 0c336d6e33f4 \
> +	"exfat: fix incorrect loading of i_blocks for large file"
> +

Thanks for adding this too, this version looks good to me now.
Reviewed-by: Zorro Lang <zlang@redhat.com>

>  _require_test
>  _require_fs_space $TEST_DIR $((4 * 1024 * 1024)) #kB
>  
> @@ -30,7 +33,10 @@ junk_dir=$TEST_DIR/$seq
>  junk_file=$junk_dir/junk
>  mkdir -p $junk_dir
>  
> -$XFS_IO_PROG -f -c "pwrite -W 0 4G" $junk_file > /dev/null
> +_create_file_sized 4G $junk_file
> +if [ $? -ne 0 ]; then
> +	echo "Could not create 4G test file"
> +fi
>  
>  iblocks=`stat -c '%b' $junk_file`
>  
> -- 
> 2.37.3
> 

