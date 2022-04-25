Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70DA3C433F5
	for <linux-fstests@archiver.kernel.org>; Mon, 25 Apr 2022 19:50:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbiDYTxM (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 25 Apr 2022 15:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236332AbiDYTxL (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 25 Apr 2022 15:53:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B60C82F5
        for <fstests@vger.kernel.org>; Mon, 25 Apr 2022 12:50:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 509A860BA5
        for <fstests@vger.kernel.org>; Mon, 25 Apr 2022 19:50:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD845C385A7;
        Mon, 25 Apr 2022 19:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650916204;
        bh=bpPU54PRap5OCb54KdMHSQQ1rF/MO2kGJbdZ+CvZ9YU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MU9fJ/vnnNuEFP/jeZG/jQ08NIG+9Rn+KQ08V23HiXm7JlZxbSStSi8a7JmX+/q38
         Q/OT+vUHxP8kM1JLvrjgxyLiKQdjVGgBVfXTCiCBo891NbWrXb4klFkFK12v1BKfHd
         nO12CF2RtU0vRmbUlxZO8kx8jFTK2w3wvrOIAka+WQPR5Vkj26X3mtdlTiS5rWKY2x
         ON6Fyc8c39zlg4xX2sYltAEk7J2kpgLvWrPXFvIknRYdHpN6sgzJkwz2HumcYn3cPI
         PnpqZIdOyliGq1JTXXEBcZBT0UDwFRjOqxs2t/5+5TvF4hgqEeWpCFJ69lhDNTo7rv
         kLMhF/NOMXTpA==
Date:   Tue, 26 Apr 2022 03:49:59 +0800
From:   Zorro Lang <zlang@kernel.org>
To:     Murphy Zhou <jencce.kernel@gmail.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] chown: fix ownership format string
Message-ID: <20220425194959.rzhbsc5g533o52xv@zlang-mailbox>
Mail-Followup-To: Murphy Zhou <jencce.kernel@gmail.com>,
        fstests@vger.kernel.org
References: <20220425082051.2wpffz2ek3jvtd6z@xzhouw.hosts.qa.psi.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220425082051.2wpffz2ek3jvtd6z@xzhouw.hosts.qa.psi.rdu2.redhat.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Apr 25, 2022 at 04:20:51PM +0800, Murphy Zhou wrote:
> After coreutils rebasing to 9.1, chown(1) behavior changes:
> "
>    chown and chroot now warn about usages like "chown root.root f",
>    which have the nonstandard and long-obsolete "." separator that
>    causes problems on platforms where user names contain ".".
>    Applications should use ":" instead of ".".
> "
> 
> https://lwn.net/Articles/891574/
> 
> With this behavior change, old format of ownership string will cause
> warning like this:
> "
> +chown: warning: '.' should be ':': '1000.1000'
> +.chown: warning: '.' should be ':': '1100.1100'
> +.chown: warning: '.' should be ':': '1200.1200'
> +.chown: warning: '.' should be ':': '1300.1300'
> +.chown: warning: '.' should be ':': '1400.1400'
> "
> 
> The new format works fine with old versions of coreutils.
> 
> Signed-off-by: Murphy Zhou <jencce.kernel@gmail.com>
> ---

Thanks for catching this new change early, this looks like a reasonable fix.
So chown would like to abandon "." separator in one day. As the ":" is
recommended by chown now, let xfstests follow it.

Reviewed-by: Zorro Lang <zlang@kernel.org>

>  common/dump       | 6 +++---
>  tests/generic/099 | 4 ++--
>  tests/generic/237 | 2 +-
>  tests/generic/318 | 2 +-
>  tests/generic/380 | 2 +-
>  tests/generic/597 | 6 +++---
>  tests/generic/598 | 6 +++---
>  7 files changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/common/dump b/common/dump
> index ea16d442..44a9a708 100644
> --- a/common/dump
> +++ b/common/dump
> @@ -526,7 +526,7 @@ _do_create_dumpdir_fill()
>  	    fi
>  	fi
>  	if [ -n "$owner" -a -n "$group" ]; then
> -	    chown $owner.$group $file
> +	    chown $owner:$group $file
>  	fi
>  	if [ -n "$perms" ]; then
>  	    chmod $perms $file
> @@ -691,10 +691,10 @@ _do_create_dump_symlinks()
>  	fi
>  
>  	if [ -n "$owner" -a -n "$group" ]; then
> -	    chown $owner.$group $file
> +	    chown $owner:$group $file
>  	fi
>  	if [ -n "$owner" -a -n "$group" ]; then
> -	    chown -h $owner.$group $file-link
> +	    chown -h $owner:$group $file-link
>  	fi
>  	if [ -n "$perms" ]; then
>  	    chmod $perms $file
> diff --git a/tests/generic/099 b/tests/generic/099
> index 6ba04dd8..5cdac9ab 100755
> --- a/tests/generic/099
> +++ b/tests/generic/099
> @@ -74,7 +74,7 @@ EOF
>  chmod u=rwx file1
>  chmod g=rw- file1
>  chmod o=r-- file1
> -chown $acl1.$acl2 file1
> +chown $acl1:$acl2 file1
>  _acl_ls file1
>  
>  echo ""
> @@ -264,7 +264,7 @@ do
>  	touch a/$i/mumble
>  done
>  popd >/dev/null
> -chown -R 12345.54321 root
> +chown -R 12345:54321 root
>  echo "Change #1..."
>  _runas -u 12345 -g 54321 -- chacl -r u::rwx,g::-w-,o::--x root
>  find root -print | sort | xargs chacl -l
> diff --git a/tests/generic/237 b/tests/generic/237
> index 93eafd84..f17e32e4 100755
> --- a/tests/generic/237
> +++ b/tests/generic/237
> @@ -38,7 +38,7 @@ mkdir $seq.dir1
>  cd $seq.dir1
>  
>  touch file1
> -chown $acl1.$acl1 file1
> +chown $acl1:$acl1 file1
>  
>  echo "Expect to FAIL"
>  _runas -u $acl2 -g $acl2 -- setfacl -m u::rwx file1 2>&1 | sed 's/^setfacl: \/.*file1: Operation not permitted$/setfacl: file1: Operation not permitted/'
> diff --git a/tests/generic/318 b/tests/generic/318
> index 5edc9f35..ed50818a 100755
> --- a/tests/generic/318
> +++ b/tests/generic/318
> @@ -72,7 +72,7 @@ _scratch_mkfs       >>$seqres.full 2>&1 || _fail "mkfs failed"
>  _scratch_mount
>  
>  touch $file
> -chown $acl1.$acl1 $file
> +chown $acl1:$acl1 $file
>  
>  # set acls from init_user_ns, to be checked from inside the userns
>  setfacl -n -m u:$acl2:rw,g:$acl2:r $file
> diff --git a/tests/generic/380 b/tests/generic/380
> index 4993dad0..21b789dd 100755
> --- a/tests/generic/380
> +++ b/tests/generic/380
> @@ -35,7 +35,7 @@ _chowning_file()
>  	let count=$start
>  	while (( count < limit )); do
>  	    touch $file
> -	    chown $count.$count $file
> +	    chown $count:$count $file
>  	    echo -n "."
>  	    let count=count+delta
>  	done
> diff --git a/tests/generic/597 b/tests/generic/597
> index aa93237e..ff985ca6 100755
> --- a/tests/generic/597
> +++ b/tests/generic/597
> @@ -46,8 +46,8 @@ HARDLINK_PROTECTION=`sysctl -n fs.protected_hardlinks`
>  test_symlink()
>  {
>  	ln -s $TEST_DIR/$seq/target $TEST_DIR/$seq/sticky_dir/symlink
> -	chown $OTHER.$OTHER $TEST_DIR/$seq/sticky_dir
> -	chown $OWNER.$OWNER $TEST_DIR/$seq/sticky_dir/symlink
> +	chown $OTHER:$OTHER $TEST_DIR/$seq/sticky_dir
> +	chown $OWNER:$OWNER $TEST_DIR/$seq/sticky_dir/symlink
>  	# If we can read the target, we followed the link
>  	_user_do "cat $TEST_DIR/$seq/sticky_dir/symlink" | _filter_test_dir
>  	rm -f $TEST_DIR/$seq/sticky_dir/symlink
> @@ -55,7 +55,7 @@ test_symlink()
>  
>  test_hardlink()
>  {
> -	chown $OWNER.$OWNER $TEST_DIR/$seq/target
> +	chown $OWNER:$OWNER $TEST_DIR/$seq/target
>  	chmod go-rw $TEST_DIR/$seq/target
>  	_user_do "ln $TEST_DIR/$seq/target $TEST_DIR/$seq/sticky_dir/hardlink" \
>  		| _filter_test_dir
> diff --git a/tests/generic/598 b/tests/generic/598
> index 160e6d4b..769c1b1a 100755
> --- a/tests/generic/598
> +++ b/tests/generic/598
> @@ -64,16 +64,16 @@ setup_tree()
>  	mkdir -p $TEST_DIR/$seq
>  	mkdir -p $TEST_DIR/$seq/sticky_dir
>  	chmod 1777 $TEST_DIR/$seq/sticky_dir
> -	chown $USER2.$USER2 $TEST_DIR/$seq/sticky_dir
> +	chown $USER2:$USER2 $TEST_DIR/$seq/sticky_dir
>  
>  	# Create file & fifo in that dir owned by $USER1, and open
>  	# normal read/write privs for world & group
>  	$XFS_IO_PROG -c "open -f $TEST_DIR/$seq/sticky_dir/file"
> -	chown $USER1.$USER1 $TEST_DIR/$seq/sticky_dir/file
> +	chown $USER1:$USER1 $TEST_DIR/$seq/sticky_dir/file
>  	chmod o+rw $TEST_DIR/$seq/sticky_dir/file
>  
>  	mkfifo $TEST_DIR/$seq/sticky_dir/fifo
> -	chown $USER1.$USER1 $TEST_DIR/$seq/sticky_dir/fifo
> +	chown $USER1:$USER1 $TEST_DIR/$seq/sticky_dir/fifo
>  	chmod o+rw $TEST_DIR/$seq/sticky_dir/fifo
>  }
>  
> -- 
> 2.27.0
> 
