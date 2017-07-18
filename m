Received: from mx1.redhat.com ([209.132.183.28]:39884 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751398AbdGRNSy (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 18 Jul 2017 09:18:54 -0400
Date: Tue, 18 Jul 2017 21:18:52 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] generic/448: don't disable extent zeroing if
 extent_max_zeroout_kb isn't supported
Message-ID: <20170718131852.GX2478@eguan.usersys.redhat.com>
References: <1500366470-10647-1-git-send-email-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1500366470-10647-1-git-send-email-yangx.jy@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: Xiao Yang <yangx.jy@cn.fujitsu.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, Jul 18, 2017 at 04:27:50PM +0800, Xiao Yang wrote:
> On some old kernel(e.g. v3.5), this case fails because it can not create
> extent_max_zeroout_kb file, as below:
>   Silence is golden
>  +./tests/generic/448: line 54: /sys/fs/ext4/sda5/extent_max_zeroout_kb: No such file or directory
>   seek sanity check failed!
> 
> The extent_max_zeroout_kb file is introduced by:
>   67a5da564f97('ext4: make the zero-out chunk size tunable')

This is available since v3.7-rc1 kernel
$ git describe --contains 67a5da564f97
v3.7-rc1~91^2~63

But ext4 SEEK_DATA/SEEK_HOLE support was added in v3.8-rc1
$ git describe --contains c8c0df241cc2
v3.8-rc1~89^2~40

IMO, you shouldn't hit this error at all, because test won't pass
_require_seek_data_hole rule. (Unless you're testing some customized
kernel with seek_data/hole backported but not that ext4 sysfs entry.)

> 
> We should only disable extent zeroing when extent_max_zeroout_kb is supported.
> 
> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
> ---
>  tests/generic/448 | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/generic/448 b/tests/generic/448
> index 87b99d7..3e92742 100755
> --- a/tests/generic/448
> +++ b/tests/generic/448
> @@ -51,7 +51,8 @@ _require_test_program "seek_sanity_test"
>  # Disable extent zeroing for ext4 as that change where holes are created
>  if [ "$FSTYP" = "ext4" ]; then
>  	DEV=`_short_dev $TEST_DEV`
> -	echo 0 >/sys/fs/ext4/$DEV/extent_max_zeroout_kb
> +	[ -f /sys/fs/ext4/$DEV/extent_max_zeroout_kb ] \
> +	&& echo 0 >/sys/fs/ext4/$DEV/extent_max_zeroout_kb

But I'm OK with adding this check, but not in this test only, this
pattern is repeated in several seek_data/hole tests, e.g.
generic/285, generic/436, generic/445 generic/448, and generic/009
(which is not a seek_data/hole test).

So I'm wondering if this hunk of code can be made into a helper and
embed it into _require_seek_data_hole. e.g. (completely untested)

# Disable extent zeroing for ext4 on the given device
_ext4_disable_extent_zeroout()
{
	local dev=${1:-$TEST_DEV}
	local sdev=`_short_dev $dev`

	[ -f /sys/fs/ext4/$sdev/extent_max_zeroout_kb ] \
	&& echo 0 >/sys/fs/ext4/$sdev/extent_max_zeroout_kb
}

And _require_seek_data_hole

_require_seek_data_hole()
{
	local dev=${1:-$TEST_DEV}
	local testfile=$TEST_DIR/$$.seek

	testseek=`$here/src/seek_sanity_test -t $testfile 2>&1`
	rm -f $testfile &>/dev/null
	echo $testseek | grep -q "Kernel does not support" && \
	    _notrun "File system does not support llseek(2) SEEK_DATA/HOLE"
	# Disable extent zeroing for ext4 as that change where holes are
	# created
	if [ "$FSTYP" == "ext4" ]; then
		_ext4_disable_extent_zeroout $dev
	fi
}

And update generic/009 accordingly to use this new helper.

What do you and/or other people think?

Thanks,
Eryu

>  fi
>  
>  $here/src/seek_sanity_test -s 18 -e 18 $BASE_TEST_FILE > $seqres.full 2>&1 ||
> -- 
> 1.8.3.1
> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
