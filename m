Return-Path: <SRS0=FsZq=CZ=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DAA2C433E2
	for <linux-fstests@archiver.kernel.org>; Wed, 16 Sep 2020 02:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E49D220BED
	for <linux-fstests@archiver.kernel.org>; Wed, 16 Sep 2020 02:11:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X5I3BY/U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726142AbgIPCLy (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 15 Sep 2020 22:11:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34562 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726028AbgIPCLy (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 15 Sep 2020 22:11:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600222312;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1StTCRuLP7cPG4jeQTXaSFNjCY3j2Bz7RoZGE6Bu4w0=;
        b=X5I3BY/U47ko+TU5lYjEAcA0J8OwOfulgmTbxhAjZQajUq5o70kBgZ3daHNkQjv8pL59sq
        JkW7m5X1xTVM979a1M+ktFDHTcDVEGKQN0hRuwa6UemyZ6wvmC+sesOyUSmPU2+2bjtwMn
        p9DoGqJXxNhksNhfG0FVJttdmX9+Qo4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-15-BLrlmqLgPvmpgCcGFSSrfA-1; Tue, 15 Sep 2020 22:11:50 -0400
X-MC-Unique: BLrlmqLgPvmpgCcGFSSrfA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0379E64142
        for <fstests@vger.kernel.org>; Wed, 16 Sep 2020 02:11:50 +0000 (UTC)
Received: from localhost (dhcp-12-102.nay.redhat.com [10.66.12.102])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 73A3D7CD20
        for <fstests@vger.kernel.org>; Wed, 16 Sep 2020 02:11:49 +0000 (UTC)
Date:   Wed, 16 Sep 2020 10:25:47 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     fstests@vger.kernel.org
Subject: Re: [PATCH 06/24] xfs: wrap xfs_db calls to the test device
Message-ID: <20200916022547.GX2937@dhcp-12-102.nay.redhat.com>
Mail-Followup-To: fstests@vger.kernel.org
References: <160013417420.2923511.6825722200699287884.stgit@magnolia>
 <160013421410.2923511.10970678307725348190.stgit@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <160013421410.2923511.10970678307725348190.stgit@magnolia>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Sep 14, 2020 at 06:43:34PM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <darrick.wong@oracle.com>
> 
> Create a _test_xfs_db analogue to _scratch_xfs_db so that we can
> encapsulate whatever strange test fs options were fed to us by the test
> runner.
> 
> Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
> ---

Good to me,
Reviewed-by: Zorro Lang <zlang@redhat.com>

>  common/xfs    |   13 +++++++++++++
>  tests/xfs/003 |   14 +++++++-------
>  tests/xfs/016 |    4 ++--
>  tests/xfs/045 |    2 +-
>  4 files changed, 23 insertions(+), 10 deletions(-)
> 
> 
> diff --git a/common/xfs b/common/xfs
> index d9a9784f..eab5e292 100644
> --- a/common/xfs
> +++ b/common/xfs
> @@ -218,6 +218,19 @@ _scratch_xfs_db()
>  	$XFS_DB_PROG "$@" $(_scratch_xfs_db_options)
>  }
>  
> +_test_xfs_db_options()
> +{
> +	TEST_OPTIONS=""
> +	[ "$USE_EXTERNAL" = yes -a ! -z "$TEST_LOGDEV" ] && \
> +		TEST_OPTIONS="-l$TEST_LOGDEV"
> +	echo $TEST_OPTIONS $* $TEST_DEV
> +}
> +
> +_test_xfs_db()
> +{
> +	$XFS_DB_PROG "$@" $(_test_xfs_db_options)
> +}
> +
>  _scratch_xfs_admin()
>  {
>  	local options=("$SCRATCH_DEV")
> diff --git a/tests/xfs/003 b/tests/xfs/003
> index 1ce3e5ce..736bf206 100755
> --- a/tests/xfs/003
> +++ b/tests/xfs/003
> @@ -38,32 +38,32 @@ test_done()
>  # real QA test starts here
>  
>  echo "=== TEST 1 ==="
> -xfs_db -r -c 'pop' -c 'type sb' $TEST_DEV
> +_test_xfs_db -r -c 'pop' -c 'type sb'
>  test_done
>  
>  echo "=== TEST 2 ==="
> -xfs_db -r -c 'push sb' $TEST_DEV
> +_test_xfs_db -r -c 'push sb'
>  test_done
>  
>  echo "=== TEST 3 ==="
> -xfs_db -r -c 'pop' -c 'push sb' $TEST_DEV
> +_test_xfs_db -r -c 'pop' -c 'push sb'
>  test_done
>  
>  echo "=== TEST 4 ==="
> -xfs_db -r -c 'type sb' -c 'print' $TEST_DEV
> +_test_xfs_db -r -c 'type sb' -c 'print'
>  test_done
>  
>  echo "=== TEST 5 ==="
> -xfs_db -r -c 'inode 128' -c 'push' -c 'type' $TEST_DEV >$tmp.out 2>&1
> +_test_xfs_db -r -c 'inode 128' -c 'push' -c 'type' >$tmp.out 2>&1
>  test_done
>  if ! grep -q "current type is \"inode\"" $tmp.out; then
>      cat $tmp.out
>  fi
>  
>  echo "=== TEST 6 ==="
> -xfs_db -r -c 'sb' -c 'a' $TEST_DEV >$tmp.out 2>&1 # don't care about output
> +_test_xfs_db -r -c 'sb' -c 'a' >$tmp.out 2>&1 # don't care about output
>  test_done
>  
>  echo "=== TEST 7 ==="
> -xfs_db -r -c 'ring' $TEST_DEV
> +_test_xfs_db -r -c 'ring'
>  test_done
> diff --git a/tests/xfs/016 b/tests/xfs/016
> index 2b41127e..e1b1b6b8 100755
> --- a/tests/xfs/016
> +++ b/tests/xfs/016
> @@ -149,7 +149,7 @@ _log_sunit()
>  
>  _after_log()
>  {
> -    xfs_db -r $1 -c "sb" -c "print" | $AWK_PROG '
> +    _scratch_xfs_db -r -c "sb" -c "print" | $AWK_PROG '
>          /logstart/  { logstart = $3 }
>          /logblocks/ { logblocks = $3 }
>          END {
> @@ -163,7 +163,7 @@ _check_corrupt()
>      f="c6c6c6c6"
>      echo "*** check for corruption"
>      echo "expect $f..." >>$seqres.full
> -    xfs_db -r -c "fsblock $2" -c "print" $1 | head | tee -a $seqres.full | \
> +    _scratch_xfs_db -r -c "fsblock $2" -c "print" | head | tee -a $seqres.full | \
>          grep -q -v "$f $f $f $f $f $f $f $f" && \
>              _fail "!!! block $2 corrupted!"
>  }
> diff --git a/tests/xfs/045 b/tests/xfs/045
> index 0c9e1b79..6a44da56 100755
> --- a/tests/xfs/045
> +++ b/tests/xfs/045
> @@ -21,7 +21,7 @@ trap "rm -f $tmp.*; exit \$status" 0 1 2 3 15
>  
>  _get_existing_uuid()
>  {
> -    xfs_db -r $TEST_DEV -c "uuid" | $AWK_PROG '/^UUID/ { print $3 }'
> +	_test_xfs_db -r -c "uuid" | $AWK_PROG '/^UUID/ { print $3 }'
>  }
>  
>  # real QA test starts here
> 

