Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47A49C43470
	for <linux-fstests@archiver.kernel.org>; Thu,  1 Apr 2021 03:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B4B961041
	for <linux-fstests@archiver.kernel.org>; Thu,  1 Apr 2021 03:40:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232893AbhDADjl (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 31 Mar 2021 23:39:41 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:2649 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232800AbhDADjJ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 31 Mar 2021 23:39:09 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R561e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=eguan@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UU.Ah8A_1617248333;
Received: from localhost(mailfrom:eguan@linux.alibaba.com fp:SMTPD_---0UU.Ah8A_1617248333)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 01 Apr 2021 11:38:53 +0800
Date:   Thu, 1 Apr 2021 11:38:53 +0800
From:   Eryu Guan <eguan@linux.alibaba.com>
To:     Pavel Reichl <preichl@redhat.com>
Cc:     fstests@vger.kernel.org, zlang@redhat.com, guan@eryu.me
Subject: Re: [PATCH v2 1/4] common/rc: Add _require_{chown,chmod,symlink}()
Message-ID: <20210401033853.GO95214@e18g06458.et15sqa>
References: <20210330220005.56019-1-preichl@redhat.com>
 <20210330220005.56019-2-preichl@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210330220005.56019-2-preichl@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Mar 31, 2021 at 12:00:02AM +0200, Pavel Reichl wrote:
> Add helper functions that ensure that test is only executed on file
> systems that implement chown, chmod and symbolic links.
> 
> Fixed test are: generic/{87,88,125,126,128,193,314,317,355,597,598}
> 
> Signed-off-by: Pavel Reichl <preichl@redhat.com>
> ---
>  common/rc         | 27 +++++++++++++++++++++++++++
>  tests/generic/087 |  1 +
>  tests/generic/088 |  1 +
>  tests/generic/125 |  1 +
>  tests/generic/126 |  1 +
>  tests/generic/128 |  1 +
>  tests/generic/193 |  1 +
>  tests/generic/314 |  1 +
>  tests/generic/317 |  1 +
>  tests/generic/355 |  1 +
>  tests/generic/597 |  1 +
>  tests/generic/598 |  1 +
>  12 files changed, 38 insertions(+)
> 
> diff --git a/common/rc b/common/rc
> index 0ce3cb0d..9cdfe21c 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -2129,6 +2129,33 @@ _require_user()
>      [ "$?" == "0" ] || _notrun "$qa_user cannot execute commands."
>  }
>  
> +# check for a chown support
> +#
> +_require_chown()
> +{
> +	if [ "$FSTYP" = "exfat" ]; then
> +		_notrun "chown is not supported on $FSTYP"
> +	fi
> +}
> +
> +# check for a chmod support
> +#
> +_require_chmod()
> +{
> +	if [ "$FSTYP" = "exfat" ]; then
> +		_notrun "chmod is not supported on $FSTYP"
> +	fi
> +}
> +

Does chown/chmod fail on exfat? Like the existing _require_symlink()
implementation and many other _require rules, we try to actually do the
action on $TEST_DIR, and check if command succeeds to see if the action
is supported by current $FSTYP. Is it possible for exfat to do the same
check?

We only use whitelist if it's impossible to do such check.

Thanks,
Eryu

> +# check for a symbolic links support
> +#
> +_require_symlink()
> +{
> +	if [ "$FSTYP" = "exfat" ]; then
> +		_notrun "symbolic links are not supported on $FSTYP"
> +	fi
> +}
> +
>  # check for a group on the machine, fsgqa as default
>  #
>  _require_group()
> diff --git a/tests/generic/087 b/tests/generic/087
> index 1f30dbf4..c3576117 100755
> --- a/tests/generic/087
> +++ b/tests/generic/087
> @@ -37,6 +37,7 @@ _cleanup()
>  # real QA test starts here
>  _supported_fs generic
>  _require_test
> +_require_chown
>  
>  QA_FS_PERMS=$here/src/fs_perms
>  
> diff --git a/tests/generic/088 b/tests/generic/088
> index 9388a083..ad99bd7e 100755
> --- a/tests/generic/088
> +++ b/tests/generic/088
> @@ -29,6 +29,7 @@ _filter()
>  # real QA test starts here
>  _supported_fs generic
>  _require_test
> +_require_chown
>  
>  path=$TEST_DIR/t_access
>  $here/src/t_access_root $path | tee $seqres.full | _filter
> diff --git a/tests/generic/125 b/tests/generic/125
> index e84248d3..8c8f5cd7 100755
> --- a/tests/generic/125
> +++ b/tests/generic/125
> @@ -25,6 +25,7 @@ _supported_fs generic
>  _require_test
>  _require_user
>  _require_odirect
> +_require_chmod
>  
>  TESTDIR=$TEST_DIR/ftrunc
>  TESTFILE=$TESTDIR/ftrunc.tmp
> diff --git a/tests/generic/126 b/tests/generic/126
> index ac25d294..636ca00d 100755
> --- a/tests/generic/126
> +++ b/tests/generic/126
> @@ -27,6 +27,7 @@ _cleanup()
>  # real QA test starts here
>  _supported_fs generic
>  _require_test
> +_require_chown
>  
>  QA_FS_PERMS=$here/src/fs_perms
>  
> diff --git a/tests/generic/128 b/tests/generic/128
> index b3e49eff..c1eae77a 100755
> --- a/tests/generic/128
> +++ b/tests/generic/128
> @@ -24,6 +24,7 @@ _supported_fs generic
>  
>  _require_scratch
>  _require_user
> +_require_chmod
>  
>  _scratch_mkfs >/dev/null 2>&1
>  _scratch_mount "-o nosuid"
> diff --git a/tests/generic/193 b/tests/generic/193
> index 3125efdd..fd0ebbf6 100755
> --- a/tests/generic/193
> +++ b/tests/generic/193
> @@ -56,6 +56,7 @@ _supported_fs generic
>  
>  _require_test
>  _require_user
> +_require_chown
>  
>  test_root=$TEST_DIR/$seq.$$.root
>  test_user=$TEST_DIR/$seq.$$.user
> diff --git a/tests/generic/314 b/tests/generic/314
> index 03df81ce..540f0feb 100755
> --- a/tests/generic/314
> +++ b/tests/generic/314
> @@ -29,6 +29,7 @@ _cleanup()
>  _supported_fs generic
>  _require_test
>  _require_user
> +_require_chown
>  
>  rm -rf $TEST_DIR/$seq-dir
>  
> diff --git a/tests/generic/317 b/tests/generic/317
> index 29c37a57..289dfabe 100755
> --- a/tests/generic/317
> +++ b/tests/generic/317
> @@ -45,6 +45,7 @@ _require_scratch
>  _require_user
>  _require_ugid_map
>  _require_userns
> +_require_chown
>  qa_user_id=`id -u $qa_user`
>  
>  _filter_output()
> diff --git a/tests/generic/355 b/tests/generic/355
> index 161dd042..74fba0f9 100755
> --- a/tests/generic/355
> +++ b/tests/generic/355
> @@ -32,6 +32,7 @@ _supported_fs generic
>  _require_test
>  _require_user
>  _require_odirect
> +_require_chown
>  
>  testfile=$TEST_DIR/$seq.test
>  rm -f $testfile
> diff --git a/tests/generic/597 b/tests/generic/597
> index ba769d73..f596406c 100755
> --- a/tests/generic/597
> +++ b/tests/generic/597
> @@ -43,6 +43,7 @@ _require_sysctl_variable fs.protected_hardlinks
>  _require_user fsgqa2
>  # Do this SECOND so that qa_user is fsgqa, and _user_do uses that account
>  _require_user fsgqa
> +_require_symlink
>  
>  OWNER=fsgqa2
>  OTHER=fsgqa
> diff --git a/tests/generic/598 b/tests/generic/598
> index 6b765275..230c3ac7 100755
> --- a/tests/generic/598
> +++ b/tests/generic/598
> @@ -43,6 +43,7 @@ _require_sysctl_variable fs.protected_fifos
>  _require_user fsgqa2
>  # Do this SECOND so that qa_user is fsgqa, and _user_do uses that account
>  _require_user fsgqa
> +_require_chmod
>  
>  USER1=fsgqa2
>  USER2=fsgqa
> -- 
> 2.30.2
