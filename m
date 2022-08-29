Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A8ACECAAD4
	for <linux-fstests@archiver.kernel.org>; Mon, 29 Aug 2022 13:24:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbiH2NYJ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 29 Aug 2022 09:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231175AbiH2NXq (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 29 Aug 2022 09:23:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B4B92F41
        for <fstests@vger.kernel.org>; Mon, 29 Aug 2022 06:21:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CD410B80EF3
        for <fstests@vger.kernel.org>; Mon, 29 Aug 2022 13:20:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C13F2C433C1;
        Mon, 29 Aug 2022 13:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661779215;
        bh=yA7Ygy6/4I2QpwLD5u7qO3B4auQ+JitDGVkiidJPGfo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MlxIv4+LqM6CXgHbpAkCFW/tNXwOYPH9KqU8/utUmCjSf9hsjpmE9pLU0dWSZM3yR
         Yv4dmyzS8QQLfhtVc8B+t8MX5bPnBht2jEwxq56e97bjfJfhQF3cE5PmSB+sapgN9Y
         OVDeUu2iyNRSfCdFreL5HzY4Qtd0ukfv/EGLJIoEZClkLuuQ0vnCNUHlM5XhB5LL9s
         JAkVHHlQ4b4cAClfgawcw11zRxCW0yD+E999ey3NmkubHUJqYljQDfni641iLmBtr6
         SQ25LG5rRNHd11AQ80MwqgFxPTamvIwD649JF4jX42GMnClDBiLL+o78zVhXZhVyua
         IqLJJ50W/TUXw==
Date:   Mon, 29 Aug 2022 15:20:11 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Yang Xu <xuyang2018.jy@fujitsu.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v2 2/2] vfs: Add new setgid_create_acl test
Message-ID: <20220829132011.krq2er4ghhwwq5kj@wittgenstein>
References: <20220725142020.rtc2mgfhcw47v4t4@wittgenstein>
 <1658827881-2347-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1658827881-2347-2-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1658827881-2347-2-git-send-email-xuyang2018.jy@fujitsu.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Jul 26, 2022 at 05:31:21PM +0800, Yang Xu wrote:
> The current_umask() is stripped from the mode directly in the vfs if the
> filesystem either doesn't support acls or the filesystem has been
> mounted without posic acl support.
> 
> If the filesystem does support acls then current_umask() stripping is
> deferred to posix_acl_create(). So when the filesystem calls
> posix_acl_create() and there are no acls set or not supported then
> current_umask() will be stripped.
> 
> If the parent directory has a default acl then permissions are based off
> of that and current_umask() is ignored. Specifically, if the ACL has an
> ACL_MASK entry, the group permissions correspond to the permissions of
> the ACL_MASK entry. Otherwise, if the ACL has no ACL_MASK entry, the
> group permissions correspond to the permissions of the ACL_GROUP_OBJ
> entry.
> 
> Here we only use setfacl to set default acl or add ACL_MASK to check
> whether inode strip  S_ISGID works correctly.
> 
> Like umask test, this patch is also designed to test kernel patchset behaviour
> "move S_ISGID stripping into the vfs* helper"
> 
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---

Hey Yang,

Thanks for your patches! Just a minor comment below.

> 1.add kernel commit id
> 2.move umask into parent process intead of child process
> 3.remove duplicated comment for ACL_GROUP_OBJ and ACL_MASK because
> we have mentioned it before the function
>  src/vfs/idmapped-mounts.c | 704 ++++++++++++++++++++++++++++++++++++++
>  src/vfs/idmapped-mounts.h |   1 +
>  src/vfs/vfstest.c         | 345 ++++++++++++++++++-
>  tests/generic/999         |  33 ++
>  tests/generic/999.out     |   2 +
>  5 files changed, 1084 insertions(+), 1 deletion(-)
>  create mode 100755 tests/generic/999
>  create mode 100644 tests/generic/999.out
> 
> diff --git a/src/vfs/idmapped-mounts.c b/src/vfs/idmapped-mounts.c
> index f63ac44b..f934cf4a 100644
> --- a/src/vfs/idmapped-mounts.c
> +++ b/src/vfs/idmapped-mounts.c
> @@ -8083,6 +8083,700 @@ out:
>  	return fret;
>  }
>  
> +static int setgid_create_acl_idmapped(const struct vfstest_info *info)
> +{
> +	int fret = -1;
> +	int file1_fd = -EBADF, open_tree_fd = -EBADF;
> +	struct mount_attr attr = {
> +		.attr_set = MOUNT_ATTR_IDMAP,
> +	};
> +	pid_t pid;
> +	int tmpfile_fd = -EBADF;
> +	bool supported = false;
> +	char path[PATH_MAX];
> +	mode_t mode;
> +
> +	if (!caps_supported())
> +		return 0;
> +
> +	if (fchmod(info->t_dir1_fd, S_IRUSR |
> +			      S_IWUSR |
> +			      S_IRGRP |
> +			      S_IWGRP |
> +			      S_IROTH |
> +			      S_IWOTH |
> +			      S_IXUSR |
> +			      S_IXGRP |
> +			      S_IXOTH |
> +			      S_ISGID), 0) {
> +		log_stderr("failure: fchmod");
> +		goto out;
> +	}
> +
> +	/* Verify that the sid bits got raised. */
> +	if (!is_setgid(info->t_dir1_fd, "", AT_EMPTY_PATH)) {
> +		log_stderr("failure: is_setgid");
> +		goto out;
> +	}
> +
> +	/* Changing mount properties on a detached mount. */
> +	attr.userns_fd	= get_userns_fd(0, 10000, 10000);
> +	if (attr.userns_fd < 0) {
> +		log_stderr("failure: get_userns_fd");
> +		goto out;
> +	}
> +
> +	open_tree_fd = sys_open_tree(info->t_dir1_fd, "",
> +				     AT_EMPTY_PATH |
> +				     AT_NO_AUTOMOUNT |
> +				     AT_SYMLINK_NOFOLLOW |
> +				     OPEN_TREE_CLOEXEC |
> +				     OPEN_TREE_CLONE);
> +	if (open_tree_fd < 0) {
> +		log_stderr("failure: sys_open_tree");
> +		goto out;
> +	}
> +
> +	if (sys_mount_setattr(open_tree_fd, "", AT_EMPTY_PATH, &attr, sizeof(attr))) {
> +		log_stderr("failure: sys_mount_setattr");
> +		goto out;
> +	}
> +
> +	supported = openat_tmpfile_supported(open_tree_fd);
> +
> +	/* Only umask with S_IXGRP because inode strip S_ISGID will check mode
> +	 * whether has group execute or search permission.
> +	 */
> +	umask(S_IXGRP);
> +	mode = umask(S_IXGRP);
> +	if (!(mode & S_IXGRP))
> +		die("failure: umask");

All the calls to umask() in this patch should be after the fork() in the
child process. The die() helper is only supposed to be used in child
processes anyway. The rest looks fine to me. So with the umask() moved
you can add,
Tested-by: Christian Brauner (Microsoft) <brauner@kernel.org>
Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>
