Received: from mx2.suse.de ([195.135.220.15]:52684 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725937AbfDYRnw (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 25 Apr 2019 13:43:52 -0400
Date: Thu, 25 Apr 2019 19:44:53 +0200
From: David Sterba <dsterba@suse.cz>
Subject: Obsolete test? (Was: Re: [PATCH v3] generic/390: Add tests for inode
 timestamp policy)
Message-ID: <20190425174453.GN20156@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <1483501871-15389-1-git-send-email-deepa.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1483501871-15389-1-git-send-email-deepa.kernel@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Deepa Dinamani <deepa.kernel@gmail.com>
Cc: fstests@vger.kernel.org, arnd@arndb.de, y2038@lists.linaro.org
List-ID: <fstests@vger.kernel.org>

On Tue, Jan 03, 2017 at 07:51:11PM -0800, Deepa Dinamani wrote:
> The test helps to validate clamping and mount behaviors
> according to supported file system timestamp ranges.
> 
> Note that the test can fail on 32-bit systems for a
> few file systems. This will be corrected when vfs is
> transitioned to use 64-bit timestamps.
> 
> Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
> ---
> The branch of the kernel tree can be located at
> 
> https://github.com/deepa-hub/vfs refs/heads/vfs_timestamp_policy

It's 2019 and the functionality hasn't been merged to kernel, but maybe
there's a replacement I have missed.

> +# timestamp ranges support.
> +_require_y2038()
> +{
> +	local device=${1:-$TEST_DEV}
> +	local sysfsdir=/proc/sys/fs/fs-timestamp-check-on
> +
> +	if [ ! -e $sysfsdir ]; then
> +		_notrun "no kernel support for y2038 sysfs switch"
> +	fi

This will always fail, so either the kernel functionality gets merged or
the test dropped. Can you let us know the status? Thanks.
