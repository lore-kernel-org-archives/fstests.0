Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F445C433EF
	for <linux-fstests@archiver.kernel.org>; Sun, 16 Jan 2022 04:51:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbiAPEvf (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sat, 15 Jan 2022 23:51:35 -0500
Received: from out20-98.mail.aliyun.com ([115.124.20.98]:47593 "EHLO
        out20-98.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbiAPEvf (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 15 Jan 2022 23:51:35 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07442486|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.0292042-0.00315104-0.967645;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047201;MF=guan@eryu.me;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.Mdlujxx_1642308693;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.Mdlujxx_1642308693)
          by smtp.aliyun-inc.com(10.147.40.233);
          Sun, 16 Jan 2022 12:51:33 +0800
Date:   Sun, 16 Jan 2022 12:51:32 +0800
From:   Eryu Guan <guan@eryu.me>
To:     Christian Brauner <brauner@kernel.org>
Cc:     fstests@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Seth Forshee <sforshee@digitalocean.com>,
        Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH 1/2] idmapped-mounts: add fs_allow_idmap() helper
Message-ID: <YeOkVHBnpkQRQlIR@desktop>
References: <20220113132421.865002-1-brauner@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220113132421.865002-1-brauner@kernel.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Jan 13, 2022 at 02:24:20PM +0100, Christian Brauner wrote:
> Move the check whether the underlying filesystem supports idmapped
> mounts into a separate helper. We will use it in the following patch to
> make it possible to always run all tests that don't require idmapped
> mounts.
> 
> Cc: Seth Forshee <sforshee@digitalocean.com>
> Cc: Eryu Guan <guaneryu@gmail.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: fstests@vger.kernel.org
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  src/idmapped-mounts/idmapped-mounts.c | 57 ++++++++++++++-------------
>  1 file changed, 30 insertions(+), 27 deletions(-)
> 
> diff --git a/src/idmapped-mounts/idmapped-mounts.c b/src/idmapped-mounts/idmapped-mounts.c
> index da690779..a78a901f 100644
> --- a/src/idmapped-mounts/idmapped-mounts.c
> +++ b/src/idmapped-mounts/idmapped-mounts.c
> @@ -13907,6 +13907,35 @@ static bool run_test(struct t_idmapped_mounts suite[], size_t suite_size)
>  	return true;
>  }
>  
> +static bool fs_allow_idmap(void)
> +{
> +	int ret;
> +	int open_tree_fd = -EBADF;
> +	struct mount_attr attr = {
> +		.attr_set	= MOUNT_ATTR_IDMAP,
> +		.userns_fd	= -EBADF,
> +	};
> +
> +	/* Changing mount properties on a detached mount. */
> +	attr.userns_fd = get_userns_fd(0, 1000, 1);
> +	if (attr.userns_fd < 0)
> +		exit(EXIT_FAILURE);

IMHO, it'd be better to return false here and let caller decide if we
should exit or not.

Thanks,
Eryu

> +
> +	open_tree_fd = sys_open_tree(t_mnt_fd, "",
> +				     AT_EMPTY_PATH | AT_NO_AUTOMOUNT |
> +				     AT_SYMLINK_NOFOLLOW | OPEN_TREE_CLOEXEC |
> +				     OPEN_TREE_CLONE);
> +	if (open_tree_fd < 0)
> +		ret = -1;
> +	else
> +		ret = sys_mount_setattr(open_tree_fd, "", AT_EMPTY_PATH, &attr,
> +					sizeof(attr));
> +	close(open_tree_fd);
> +	close(attr.userns_fd);
> +
> +	return ret == 0;
> +}
> +
>  int main(int argc, char *argv[])
>  {
>  	int fret, ret;
> @@ -13987,34 +14016,8 @@ int main(int argc, char *argv[])
>  	 * idmapped mounts.
>  	 */
>  	if (supported) {
> -		int open_tree_fd = -EBADF;
> -		struct mount_attr attr = {
> -			.attr_set	= MOUNT_ATTR_IDMAP,
> -			.userns_fd	= -EBADF,
> -		};
> -
> -		/* Changing mount properties on a detached mount. */
> -		attr.userns_fd	= get_userns_fd(0, 1000, 1);
> -		if (attr.userns_fd < 0)
> +		if (!fs_allow_idmap())
>  			exit(EXIT_FAILURE);
> -
> -		open_tree_fd = sys_open_tree(t_mnt_fd, "",
> -					     AT_EMPTY_PATH |
> -					     AT_NO_AUTOMOUNT |
> -					     AT_SYMLINK_NOFOLLOW |
> -					     OPEN_TREE_CLOEXEC |
> -					     OPEN_TREE_CLONE);
> -		if (open_tree_fd < 0)
> -			ret = -1;
> -		else
> -			ret = sys_mount_setattr(open_tree_fd, "", AT_EMPTY_PATH, &attr, sizeof(attr));
> -
> -		close(open_tree_fd);
> -		close(attr.userns_fd);
> -
> -		if (ret)
> -			exit(EXIT_FAILURE);
> -
>  		exit(EXIT_SUCCESS);
>  	}
>  
> 
> base-commit: c61c1e2f4cad89d4f900eaef173616b309228110
> -- 
> 2.32.0
