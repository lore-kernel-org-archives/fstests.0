Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A64C433EF
	for <linux-fstests@archiver.kernel.org>; Wed,  1 Jun 2022 17:33:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348929AbiFARdA (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 1 Jun 2022 13:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346250AbiFARc7 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 1 Jun 2022 13:32:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC385003E
        for <fstests@vger.kernel.org>; Wed,  1 Jun 2022 10:32:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BBE64B81BCE
        for <fstests@vger.kernel.org>; Wed,  1 Jun 2022 17:32:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54F42C385A5;
        Wed,  1 Jun 2022 17:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654104775;
        bh=gRE0Ka/I3MB8mouJmVViqFkfXLHTo103utZVdxSlaCI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TUP5PbYM9be4TLGNp/74B9Mpqt7lLcKd/CJdiTcgCfciDW6W7axJaj7Gn/6f+IlYV
         XSziWEJwx9fhiEp17KqKnlo+vruARuG4DLcDcWHZfcBncWSeFsvb9QUWbulspg8y+G
         CYpVwRUGnK3E4cgaJoCoVl8r+vmfVNZ9Gq3NufIV3dgt/XU5kqJOn0yunuMDq6V3+x
         F/0pca5rVdNjJTE0bAoVRgTsa/bnHontbbE69L06jh0dw0/KYIRJYDED74IS7II2RB
         5w0L5oTx3eOm33KpcUgzid0f0tfTjw9EZQU9SAm4kaSNSK9ufoRZZt0J9TfHOHvRl0
         Sf/URPp1TBdvw==
Date:   Wed, 1 Jun 2022 10:32:54 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Zorro Lang <zlang@kernel.org>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v2 1/5] generic/139: require 512 bytes to be the minimum
 dio size
Message-ID: <YpeixjeZ8kdVw/+7@magnolia>
References: <20220601063730.1726879-1-zlang@kernel.org>
 <20220601063730.1726879-2-zlang@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220601063730.1726879-2-zlang@kernel.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Jun 01, 2022 at 02:37:26PM +0800, Zorro Lang wrote:
> Due to generic/139 tests base on 512 bytes aligned, so skip this test
> if the minimum dio write size >512. This patch also change the
> common/rc::_require_dio helper, supports a minimum aligned size
> argument.
> 
> Signed-off-by: Zorro Lang <zlang@kernel.org>
> ---
>  common/rc         | 17 ++++++++++++++---
>  tests/generic/139 |  2 +-
>  2 files changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/common/rc b/common/rc
> index 2f31ca46..6d384eaf 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -2721,9 +2721,12 @@ _require_xfs_io_command()
>  	fi
>  }
>  
> -# check that kernel and filesystem support direct I/O
> +# check that kernel and filesystem support direct I/O, and check if "$1" size
> +# aligned (optional) is supported
>  _require_odirect()
>  {
> +	local alignment=${1:+"-b $1"}
> +
>  	if [ $FSTYP = "ext4" ] || [ $FSTYP = "f2fs" ] ; then
>  		if echo "$MOUNT_OPTIONS" | grep -q "test_dummy_encryption"; then
>  			_notrun "$FSTYP encryption doesn't support O_DIRECT"
> @@ -2735,9 +2738,17 @@ _require_odirect()
>  		fi
>  	fi
>  	local testfile=$TEST_DIR/$$.direct
> -	$XFS_IO_PROG -F -f -d -c "pwrite 0 20k" $testfile > /dev/null 2>&1
> +	local opt
> +	if [ -n "$1" ];then
> +		opt="-b $1"
> +	fi

Doesn't this duplicate the assignment of @alignment above?

--D

> +	$XFS_IO_PROG -F -f -d -c "pwrite $opt 0 20k" $testfile > /dev/null 2>&1
>  	if [ $? -ne 0 ]; then
> -		_notrun "O_DIRECT is not supported"
> +		if [ -n "$alignment" ]; then
> +			_notrun "O_DIRECT aligned to $1 bytes is not supported"
> +		else
> +			_notrun "O_DIRECT is not supported"
> +		fi
>  	fi
>  	rm -f $testfile 2>&1 > /dev/null
>  }
> diff --git a/tests/generic/139 b/tests/generic/139
> index 0bbc222c..3eb1519d 100755
> --- a/tests/generic/139
> +++ b/tests/generic/139
> @@ -26,7 +26,7 @@ _cleanup()
>  # real QA test starts here
>  _require_test_reflink
>  _require_cp_reflink
> -_require_odirect
> +_require_odirect 512
>  
>  testdir=$TEST_DIR/test-$seq
>  rm -rf $testdir
> -- 
> 2.31.1
> 
