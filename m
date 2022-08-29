Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE5F3ECAAD5
	for <linux-fstests@archiver.kernel.org>; Mon, 29 Aug 2022 13:52:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbiH2Nwg (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 29 Aug 2022 09:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiH2Nwf (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 29 Aug 2022 09:52:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A992086B66
        for <fstests@vger.kernel.org>; Mon, 29 Aug 2022 06:52:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2413AB81088
        for <fstests@vger.kernel.org>; Mon, 29 Aug 2022 13:52:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4B96C433C1;
        Mon, 29 Aug 2022 13:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661781149;
        bh=PlzxMS/HlukwTtn1WfWEjpWWdkGykHtNykEokRul5aw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=egyHBEg9ut9GjhlFLPwALgTVUDA+o56uUrJOII7W96+Zuo4NvTPYPM4aX9RB6UZXs
         krJBblMU27Juwj/MzRoMa5FyKfxBEVsQZEnQlMdTES+UVB40JagPkWzC1zyigHagXA
         2lMg2G96Kkod4q3ax2EC3c9l6MxERaPGXp+PcPlNMq5/1Fb72I/6FXmbhz1vZNX5sg
         ECX7dGPj/LLokkOmNtX3hU7lCE3Hpxs3jCndGnymzo//1R8Iz269sidfBrBgJdpoBh
         QQcs2WQTdJ6KTE05WB0eY9LZ9Xfr51buGIoLFeM/0izkYOCO8EOZETKzum8/+7XbAs
         lD6ghW1GUsLJA==
Date:   Mon, 29 Aug 2022 15:52:25 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Yang Xu <xuyang2018.jy@fujitsu.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v2 2/2] vfs: Add new setgid_create_acl test
Message-ID: <20220829135225.wscmhw4dqkzitcvf@wittgenstein>
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

Thank your for all that work! Just a few nits.

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

Please move all the umask() calls after the fork() into the child.

> +
> +	pid = fork();
> +	if (pid < 0) {
> +		log_stderr("failure: fork");
> +		goto out;
> +	}
> +	if (pid == 0) {
> +		/* The group permissions correspond to the permissions of the
> +		 * ACL_MASK entry.
> +		 */
> +		snprintf(t_buf, sizeof(t_buf), "setfacl -d -m u::rwx,g::rw,o::rwx,m:rw %s/%s", info->t_mountpoint, T_DIR1);
> +		if (system(t_buf))
> +			die("failure: system");
> +
> +		if (!switch_ids(10000, 11000))
> +			die("failure: switch fsids");
> +
> +		/* create regular file via open() */
> +		file1_fd = openat(open_tree_fd, FILE1, O_CREAT | O_EXCL | O_CLOEXEC, S_IXGRP | S_ISGID);
> +		if (file1_fd < 0)
> +			die("failure: create");
> +
> +		/* Neither in_group_p() nor capable_wrt_inode_uidgid() so setgid
> +		 * bit needs to be stripped.
> +		 */
> +		if (is_setgid(open_tree_fd, FILE1, 0))
> +			die("failure: is_setgid");
> +
> +		if (is_ixgrp(open_tree_fd, FILE1, 0))
> +			die("failure: is_ixgrp");
> +
> +		/* create directory */
> +		if (mkdirat(open_tree_fd, DIR1, 0000))
> +			die("failure: create");
> +
> +		if (xfs_irix_sgid_inherit_enabled(info->t_fstype)) {
> +			/* We're not in_group_p(). */
> +			if (is_setgid(open_tree_fd, DIR1, 0))
> +				die("failure: is_setgid");
> +		} else {
> +			/* Directories always inherit the setgid bit. */
> +			if (!is_setgid(open_tree_fd, DIR1, 0))
> +				die("failure: is_setgid");
> +		}
> +
> +		if (is_ixgrp(open_tree_fd, DIR1, 0))
> +			die("failure: is_ixgrp");
> +
> +		/* create a special file via mknodat() vfs_create */
> +		if (mknodat(open_tree_fd, FILE2, S_IFREG | S_ISGID | S_IXGRP, 0))
> +			die("failure: mknodat");
> +
> +		if (is_setgid(open_tree_fd, FILE2, 0))
> +			die("failure: is_setgid");
> +
> +		if (is_ixgrp(open_tree_fd, FILE2, 0))
> +			die("failure: is_ixgrp");
> +
> +		/* create a whiteout device via mknodat() vfs_mknod */
> +		if (mknodat(open_tree_fd, CHRDEV1, S_IFCHR | S_ISGID | S_IXGRP, 0))
> +			die("failure: mknodat");
> +
> +		if (is_setgid(open_tree_fd, CHRDEV1, 0))
> +			die("failure: is_setgid");
> +
> +		if (is_ixgrp(open_tree_fd, CHRDEV1, 0))
> +			die("failure: is_ixgrp");
> +
> +		/*
> +		 * In setgid directories newly created files always inherit the
> +		 * gid from the parent directory. Verify that the file is owned
> +		 * by gid 10000, not by gid 11000.
> +		 */
> +		if (!expected_uid_gid(open_tree_fd, FILE1, 0, 10000, 10000))
> +			die("failure: check ownership");
> +
> +		/*
> +		 * In setgid directories newly created directories always
> +		 * inherit the gid from the parent directory. Verify that the
> +		 * directory is owned by gid 10000, not by gid 11000.
> +		 */
> +		if (!expected_uid_gid(open_tree_fd, DIR1, 0, 10000, 10000))
> +			die("failure: check ownership");
> +
> +		if (!expected_uid_gid(open_tree_fd, FILE2, 0, 10000, 10000))
> +			die("failure: check ownership");
> +
> +		if (!expected_uid_gid(open_tree_fd, CHRDEV1, 0, 10000, 10000))
> +			die("failure: check ownership");
> +
> +		if (unlinkat(open_tree_fd, FILE1, 0))
> +			die("failure: delete");
> +
> +		if (unlinkat(open_tree_fd, DIR1, AT_REMOVEDIR))
> +			die("failure: delete");
> +
> +		if (unlinkat(open_tree_fd, FILE2, 0))
> +			die("failure: delete");
> +
> +		if (unlinkat(open_tree_fd, CHRDEV1, 0))
> +			die("failure: delete");
> +
> +		/* create tmpfile via filesystem tmpfile api */
> +		if (supported) {
> +			tmpfile_fd = openat(open_tree_fd, ".", O_TMPFILE | O_RDWR, S_IXGRP | S_ISGID);
> +			if (tmpfile_fd < 0)
> +				die("failure: create");
> +			/* link the temporary file into the filesystem, making it permanent */
> +			snprintf(path, PATH_MAX,  "/proc/self/fd/%d", tmpfile_fd);
> +			if (linkat(AT_FDCWD, path, open_tree_fd, FILE3, AT_SYMLINK_FOLLOW))
> +				die("failure: linkat");
> +			if (close(tmpfile_fd))
> +				die("failure: close");
> +			if (is_setgid(open_tree_fd, FILE3, 0))
> +				die("failure: is_setgid");
> +			if (is_ixgrp(open_tree_fd, FILE3, 0))
> +				die("failure: is_ixgrp");
> +			if (!expected_uid_gid(open_tree_fd, FILE3, 0, 10000, 10000))
> +				die("failure: check ownership");
> +			if (unlinkat(open_tree_fd, FILE3, 0))
> +				die("failure: delete");
> +		}
> +
> +		exit(EXIT_SUCCESS);
> +	}
> +	if (wait_for_pid(pid))
> +		goto out;
> +
> +	pid = fork();
> +	if (pid < 0) {
> +		log_stderr("failure: fork");
> +		goto out;
> +	}
> +	if (pid == 0) {
> +		/* The group permissions correspond to the permissions of the
> +		 * ACL_GROUP_OBJ entry.
> +		 */
> +		snprintf(t_buf, sizeof(t_buf), "setfacl -d -m u::rwx,g::rwx,o::rwx, %s/%s", info->t_mountpoint, T_DIR1);
> +		if (system(t_buf))
> +			die("failure: system");
> +
> +		if (!switch_ids(10000, 11000))
> +			die("failure: switch fsids");
> +
> +		/* create regular file via open() */
> +		file1_fd = openat(open_tree_fd, FILE1, O_CREAT | O_EXCL | O_CLOEXEC, S_IXGRP | S_ISGID);
> +		if (file1_fd < 0)
> +			die("failure: create");
> +
> +		/* Neither in_group_p() nor capable_wrt_inode_uidgid() so setgid
> +		 * bit needs to be stripped.
> +		 */
> +		if (is_setgid(open_tree_fd, FILE1, 0))
> +			die("failure: is_setgid");
> +
> +		if (!is_ixgrp(open_tree_fd, FILE1, 0))
> +			die("failure: is_ixgrp");
> +
> +		/* create directory */
> +		if (mkdirat(open_tree_fd, DIR1, 0000))
> +			die("failure: create");
> +
> +		if (xfs_irix_sgid_inherit_enabled(info->t_fstype)) {
> +			/* We're not in_group_p(). */
> +			if (is_setgid(open_tree_fd, DIR1, 0))
> +				die("failure: is_setgid");
> +		} else {
> +			/* Directories always inherit the setgid bit. */
> +			if (!is_setgid(open_tree_fd, DIR1, 0))
> +				die("failure: is_setgid");
> +		}
> +
> +		if (is_ixgrp(open_tree_fd, DIR1, 0))
> +			die("failure: is_ixgrp");
> +
> +		/* create a special file via mknodat() vfs_create */
> +		if (mknodat(open_tree_fd, FILE2, S_IFREG | S_ISGID | S_IXGRP, 0))
> +			die("failure: mknodat");
> +
> +		if (is_setgid(open_tree_fd, FILE2, 0))
> +			die("failure: is_setgid");
> +
> +		if (!is_ixgrp(open_tree_fd, FILE2, 0))
> +			die("failure: is_ixgrp");
> +
> +		/* create a whiteout device via mknodat() vfs_mknod */
> +		if (mknodat(open_tree_fd, CHRDEV1, S_IFCHR | S_ISGID | S_IXGRP, 0))
> +			die("failure: mknodat");
> +
> +		if (is_setgid(open_tree_fd, CHRDEV1, 0))
> +			die("failure: is_setgid");
> +
> +		if (!is_ixgrp(open_tree_fd, CHRDEV1, 0))
> +			die("failure: is_ixgrp");
> +
> +		/*
> +		 * In setgid directories newly created files always inherit the
> +		 * gid from the parent directory. Verify that the file is owned
> +		 * by gid 10000, not by gid 11000.
> +		 */
> +		if (!expected_uid_gid(open_tree_fd, FILE1, 0, 10000, 10000))
> +			die("failure: check ownership");
> +
> +		/*
> +		 * In setgid directories newly created directories always
> +		 * inherit the gid from the parent directory. Verify that the
> +		 * directory is owned by gid 10000, not by gid 11000.
> +		 */
> +		if (!expected_uid_gid(open_tree_fd, DIR1, 0, 10000, 10000))
> +			die("failure: check ownership");
> +
> +		if (!expected_uid_gid(open_tree_fd, FILE2, 0, 10000, 10000))
> +			die("failure: check ownership");
> +
> +		if (!expected_uid_gid(open_tree_fd, CHRDEV1, 0, 10000, 10000))
> +			die("failure: check ownership");
> +
> +		if (unlinkat(open_tree_fd, FILE1, 0))
> +			die("failure: delete");
> +
> +		if (unlinkat(open_tree_fd, DIR1, AT_REMOVEDIR))
> +			die("failure: delete");
> +
> +		if (unlinkat(open_tree_fd, FILE2, 0))
> +			die("failure: delete");
> +
> +		if (unlinkat(open_tree_fd, CHRDEV1, 0))
> +			die("failure: delete");
> +
> +		/* create tmpfile via filesystem tmpfile api */
> +		if (supported) {
> +			tmpfile_fd = openat(open_tree_fd, ".", O_TMPFILE | O_RDWR, S_IXGRP | S_ISGID);
> +			if (tmpfile_fd < 0)
> +				die("failure: create");
> +			/* link the temporary file into the filesystem, making it permanent */
> +			snprintf(path, PATH_MAX,  "/proc/self/fd/%d", tmpfile_fd);
> +			if (linkat(AT_FDCWD, path, open_tree_fd, FILE3, AT_SYMLINK_FOLLOW))
> +				die("failure: linkat");
> +			if (close(tmpfile_fd))
> +				die("failure: close");
> +			if (is_setgid(open_tree_fd, FILE3, 0))
> +				die("failure: is_setgid");
> +			if (!is_ixgrp(open_tree_fd, FILE3, 0))
> +				die("failure: is_ixgrp");
> +			if (!expected_uid_gid(open_tree_fd, FILE3, 0, 10000, 10000))
> +				die("failure: check ownership");
> +			if (unlinkat(open_tree_fd, FILE3, 0))
> +				die("failure: delete");
> +		}
> +
> +		exit(EXIT_SUCCESS);
> +	}
> +	if (wait_for_pid(pid))
> +		goto out;
> +
> +	fret = 0;
> +	log_debug("Ran test");
> +out:
> +	safe_close(attr.userns_fd);
> +	safe_close(file1_fd);
> +	safe_close(open_tree_fd);
> +
> +	return fret;
> +}
> +
> +static int setgid_create_acl_idmapped_in_userns(const struct vfstest_info *info)
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
> +
> +	/*
> +	 * Below we verify that setgid inheritance for a newly created file or
> +	 * directory works correctly. As part of this we need to verify that
> +	 * newly created files or directories inherit their gid from their
> +	 * parent directory. So we change the parent directorie's gid to 1000
> +	 * and create a file with fs{g,u}id 0 and verify that the newly created
> +	 * file and directory inherit gid 1000, not 0.
> +	 */
> +	if (fchownat(info->t_dir1_fd, "", -1, 1000, AT_SYMLINK_NOFOLLOW | AT_EMPTY_PATH)) {
> +		log_stderr("failure: fchownat");
> +		goto out;
> +	}
> +
> +	pid = fork();
> +	if (pid < 0) {
> +		log_stderr("failure: fork");
> +		goto out;
> +	}
> +	if (pid == 0) {
> +		/* The group permissions correspond to the permissions of the
> +		 * ACL_MASK entry.
> +		 */
> +		snprintf(t_buf, sizeof(t_buf), "setfacl -d -m u::rwx,g::rw,o::rwx,m:rw %s/%s", info->t_mountpoint, T_DIR1);
> +		if (system(t_buf))
> +			die("failure: system");
> +
> +		if (!caps_supported()) {
> +			log_debug("skip: capability library not installed");
> +			exit(EXIT_SUCCESS);
> +		}
> +
> +		if (!switch_userns(attr.userns_fd, 0, 0, false))
> +			die("failure: switch_userns");
> +
> +		if (!caps_down_fsetid())
> +			die("failure: caps_down_fsetid");
> +
> +		/* create regular file via open() */
> +		file1_fd = openat(open_tree_fd, FILE1, O_CREAT | O_EXCL | O_CLOEXEC, S_IXGRP | S_ISGID);
> +		if (file1_fd < 0)
> +			die("failure: create");
> +
> +		/* Neither in_group_p() nor capable_wrt_inode_uidgid() so setgid
> +		 * bit needs to be stripped.
> +		 */
> +		if (is_setgid(open_tree_fd, FILE1, 0))
> +			die("failure: is_setgid");
> +
> +		if (is_ixgrp(open_tree_fd, FILE1, 0))
> +			die("failure: is_ixgrp");
> +
> +		/* create directory */
> +		if (mkdirat(open_tree_fd, DIR1, 0000))
> +			die("failure: create");
> +
> +		if (xfs_irix_sgid_inherit_enabled(info->t_fstype)) {
> +			/* We're not in_group_p(). */
> +			if (is_setgid(open_tree_fd, DIR1, 0))
> +				die("failure: is_setgid");
> +		} else {
> +			/* Directories always inherit the setgid bit. */
> +			if (!is_setgid(open_tree_fd, DIR1, 0))
> +				die("failure: is_setgid");
> +		}
> +
> +		if (is_ixgrp(open_tree_fd, DIR1, 0))
> +			die("failure: is_ixgrp");
> +
> +		/* create a special file via mknodat() vfs_create */
> +		if (mknodat(open_tree_fd, FILE2, S_IFREG | S_ISGID | S_IXGRP, 0))
> +			die("failure: mknodat");
> +
> +		if (is_setgid(open_tree_fd, FILE2, 0))
> +			die("failure: is_setgid");
> +
> +		if (is_ixgrp(open_tree_fd, FILE2, 0))
> +			die("failure: is_ixgrp");
> +
> +		/* create a whiteout device via mknodat() vfs_mknod */
> +		if (mknodat(open_tree_fd, CHRDEV1, S_IFCHR | S_ISGID | S_IXGRP, 0))
> +			die("failure: mknodat");
> +
> +		if (is_setgid(open_tree_fd, CHRDEV1, 0))
> +			die("failure: is_setgid");
> +
> +		if (is_ixgrp(open_tree_fd, CHRDEV1, 0))
> +			die("failure: is_ixgrp");
> +
> +		/*
> +		 * In setgid directories newly created files always inherit the
> +		 * gid from the parent directory. Verify that the file is owned
> +		 * by gid 1000, not by gid 0.
> +		 */
> +		if (!expected_uid_gid(open_tree_fd, FILE1, 0, 0, 1000))
> +			die("failure: check ownership");
> +
> +		/*
> +		 * In setgid directories newly created directories always
> +		 * inherit the gid from the parent directory. Verify that the
> +		 * directory is owned by gid 1000, not by gid 0.
> +		 */
> +		if (!expected_uid_gid(open_tree_fd, DIR1, 0, 0, 1000))
> +			die("failure: check ownership");
> +
> +		if (!expected_uid_gid(open_tree_fd, FILE2, 0, 0, 1000))
> +			die("failure: check ownership");
> +
> +		if (!expected_uid_gid(open_tree_fd, CHRDEV1, 0, 0, 1000))
> +			die("failure: check ownership");
> +
> +		if (unlinkat(open_tree_fd, FILE1, 0))
> +			die("failure: delete");
> +
> +		if (unlinkat(open_tree_fd, DIR1, AT_REMOVEDIR))
> +			die("failure: delete");
> +
> +		if (unlinkat(open_tree_fd, FILE2, 0))
> +			die("failure: delete");
> +
> +		if (unlinkat(open_tree_fd, CHRDEV1, 0))
> +			die("failure: delete");
> +
> +		/* create tmpfile via filesystem tmpfile api */
> +		if (supported) {
> +			tmpfile_fd = openat(open_tree_fd, ".", O_TMPFILE | O_RDWR, S_IXGRP | S_ISGID);
> +			if (tmpfile_fd < 0)
> +				die("failure: create");
> +			/* link the temporary file into the filesystem, making it permanent */
> +			snprintf(path, PATH_MAX,  "/proc/self/fd/%d", tmpfile_fd);
> +			if (linkat(AT_FDCWD, path, open_tree_fd, FILE3, AT_SYMLINK_FOLLOW))
> +				die("failure: linkat");
> +			if (close(tmpfile_fd))
> +				die("failure: close");
> +			if (is_setgid(open_tree_fd, FILE3, 0))
> +				die("failure: is_setgid");
> +			if (is_ixgrp(open_tree_fd, FILE3, 0))
> +				die("failure: is_ixgrp");
> +			if (!expected_uid_gid(open_tree_fd, FILE3, 0, 0, 1000))
> +				die("failure: check ownership");
> +			if (unlinkat(open_tree_fd, FILE3, 0))
> +				die("failure: delete");
> +		}
> +
> +		exit(EXIT_SUCCESS);
> +	}
> +	if (wait_for_pid(pid))
> +		goto out;
> +
> +	pid = fork();
> +	if (pid < 0) {
> +		log_stderr("failure: fork");
> +		goto out;
> +	}
> +	if (pid == 0) {
> +		/* The group permissions correspond to the permissions of the
> +		 * ACL_GROUP_OBJ entry.
> +		 */
> +		snprintf(t_buf, sizeof(t_buf), "setfacl -d -m u::rwx,g::rwx,o::rwx, %s/%s", info->t_mountpoint, T_DIR1);
> +		if (system(t_buf))
> +			die("failure: system");
> +
> +		if (!caps_supported()) {
> +			log_debug("skip: capability library not installed");
> +			exit(EXIT_SUCCESS);
> +		}
> +
> +		if (!switch_userns(attr.userns_fd, 0, 0, false))
> +			die("failure: switch_userns");
> +
> +		if (!caps_down_fsetid())
> +			die("failure: caps_down_fsetid");
> +
> +		/* create regular file via open() */
> +		file1_fd = openat(open_tree_fd, FILE1, O_CREAT | O_EXCL | O_CLOEXEC, S_IXGRP | S_ISGID);
> +		if (file1_fd < 0)
> +			die("failure: create");
> +
> +		/* Neither in_group_p() nor capable_wrt_inode_uidgid() so setgid
> +		 * bit needs to be stripped.
> +		 */
> +		if (is_setgid(open_tree_fd, FILE1, 0))
> +			die("failure: is_setgid");
> +
> +		if (!is_ixgrp(open_tree_fd, FILE1, 0))
> +			die("failure: is_ixgrp");
> +
> +		/* create directory */
> +		if (mkdirat(open_tree_fd, DIR1, 0000))
> +			die("failure: create");
> +
> +		if (xfs_irix_sgid_inherit_enabled(info->t_fstype)) {
> +			/* We're not in_group_p(). */
> +			if (is_setgid(open_tree_fd, DIR1, 0))
> +				die("failure: is_setgid");
> +		} else {
> +			/* Directories always inherit the setgid bit. */
> +			if (!is_setgid(open_tree_fd, DIR1, 0))
> +				die("failure: is_setgid");
> +		}
> +
> +		if (is_ixgrp(open_tree_fd, DIR1, 0))
> +			die("failure: is_ixgrp");
> +
> +		/* create a special file via mknodat() vfs_create */
> +		if (mknodat(open_tree_fd, FILE2, S_IFREG | S_ISGID | S_IXGRP, 0))
> +			die("failure: mknodat");
> +
> +		if (is_setgid(open_tree_fd, FILE2, 0))
> +			die("failure: is_setgid");
> +
> +		if (!is_ixgrp(open_tree_fd, FILE2, 0))
> +			 die("failure: is_ixgrp");
> +		/* create a whiteout device via mknodat() vfs_mknod */
> +		if (mknodat(open_tree_fd, CHRDEV1, S_IFCHR | S_ISGID | S_IXGRP, 0))
> +			die("failure: mknodat");
> +
> +		if (is_setgid(open_tree_fd, CHRDEV1, 0))
> +			die("failure: is_setgid");
> +
> +		if (!is_ixgrp(open_tree_fd, CHRDEV1, 0))
> +			 die("failure: is_ixgrp");
> +
> +		/*
> +		 * In setgid directories newly created files always inherit the
> +		 * gid from the parent directory. Verify that the file is owned
> +		 * by gid 1000, not by gid 0.
> +		 */
> +		if (!expected_uid_gid(open_tree_fd, FILE1, 0, 0, 1000))
> +			die("failure: check ownership");
> +
> +		/*
> +		 * In setgid directories newly created directories always
> +		 * inherit the gid from the parent directory. Verify that the
> +		 * directory is owned by gid 1000, not by gid 0.
> +		 */
> +		if (!expected_uid_gid(open_tree_fd, DIR1, 0, 0, 1000))
> +			die("failure: check ownership");
> +
> +		if (!expected_uid_gid(open_tree_fd, FILE2, 0, 0, 1000))
> +			die("failure: check ownership");
> +
> +		if (!expected_uid_gid(open_tree_fd, CHRDEV1, 0, 0, 1000))
> +			die("failure: check ownership");
> +
> +		if (unlinkat(open_tree_fd, FILE1, 0))
> +			die("failure: delete");
> +
> +		if (unlinkat(open_tree_fd, DIR1, AT_REMOVEDIR))
> +			die("failure: delete");
> +
> +		if (unlinkat(open_tree_fd, FILE2, 0))
> +			die("failure: delete");
> +
> +		if (unlinkat(open_tree_fd, CHRDEV1, 0))
> +			die("failure: delete");
> +
> +		/* create tmpfile via filesystem tmpfile api */
> +		if (supported) {
> +			tmpfile_fd = openat(open_tree_fd, ".", O_TMPFILE | O_RDWR, S_IXGRP | S_ISGID);
> +			if (tmpfile_fd < 0)
> +				die("failure: create");
> +			/* link the temporary file into the filesystem, making it permanent */
> +			snprintf(path, PATH_MAX,  "/proc/self/fd/%d", tmpfile_fd);
> +			if (linkat(AT_FDCWD, path, open_tree_fd, FILE3, AT_SYMLINK_FOLLOW))
> +				die("failure: linkat");
> +			if (close(tmpfile_fd))
> +				die("failure: close");
> +			if (is_setgid(open_tree_fd, FILE3, 0))
> +				die("failure: is_setgid");
> +			if (!is_ixgrp(open_tree_fd, FILE3, 0))
> +				die("failure: is_ixgrp");
> +			if (!expected_uid_gid(open_tree_fd, FILE3, 0, 0, 1000))
> +				die("failure: check ownership");
> +			if (unlinkat(open_tree_fd, FILE3, 0))
> +				die("failure: delete");
> +		}
> +
> +		exit(EXIT_SUCCESS);
> +	}
> +	if (wait_for_pid(pid))
> +		goto out;
> +
> +	fret = 0;
> +	log_debug("Ran test");
> +out:
> +	safe_close(attr.userns_fd);
> +	safe_close(file1_fd);
> +	safe_close(open_tree_fd);
> +
> +	return fret;
> +}
> +
>  static const struct test_struct t_idmapped_mounts[] = {
>  	{ acls,                                                         true,   "posix acls on regular mounts",                                                                 },
>  	{ create_in_userns,                                             true,   "create operations in user namespace",                                                          },
> @@ -8174,3 +8868,13 @@ const struct test_suite s_setgid_create_umask_idmapped_mounts = {
>  	.tests = t_setgid_create_umask_idmapped_mounts,
>  	.nr_tests = ARRAY_SIZE(t_setgid_create_umask_idmapped_mounts),
>  };
> +
> +static const struct test_struct t_setgid_create_acl_idmapped_mounts[] = {
> +	{ setgid_create_acl_idmapped,					T_REQUIRE_IDMAPPED_MOUNTS,	"create operations by using acl in directories with setgid bit set on idmapped mount",                },
> +	{ setgid_create_acl_idmapped_in_userns,				T_REQUIRE_IDMAPPED_MOUNTS,	"create operations by using acl in directories with setgid bit set on idmapped mount inside userns",  },
> +};
> +
> +const struct test_suite s_setgid_create_acl_idmapped_mounts = {
> +	.tests = t_setgid_create_acl_idmapped_mounts,
> +	.nr_tests = ARRAY_SIZE(t_setgid_create_acl_idmapped_mounts),
> +};
> diff --git a/src/vfs/idmapped-mounts.h b/src/vfs/idmapped-mounts.h
> index a9fb31ea..3b0f0825 100644
> --- a/src/vfs/idmapped-mounts.h
> +++ b/src/vfs/idmapped-mounts.h
> @@ -15,5 +15,6 @@ extern const struct test_suite s_nested_userns;
>  extern const struct test_suite s_setattr_fix_968219708108;
>  extern const struct test_suite s_setxattr_fix_705191b03d50;
>  extern const struct test_suite s_setgid_create_umask_idmapped_mounts;
> +extern const struct test_suite s_setgid_create_acl_idmapped_mounts;
>  
>  #endif /* __IDMAPPED_MOUNTS_H */
> diff --git a/src/vfs/vfstest.c b/src/vfs/vfstest.c
> index e928a1f5..f7639de3 100644
> --- a/src/vfs/vfstest.c
> +++ b/src/vfs/vfstest.c
> @@ -27,6 +27,8 @@
>  #include "missing.h"
>  #include "utils.h"
>  
> +static char t_buf[PATH_MAX];
> +
>  static void init_vfstest_info(struct vfstest_info *info)
>  {
>  	info->t_overflowuid		= 65534;
> @@ -1913,6 +1915,325 @@ out:
>  	return fret;
>  }
>  
> +/*
> + * If the parent directory has a default acl then permissions are based off
> + * of that and current_umask() is ignored. Specifically, if the ACL has an
> + * ACL_MASK entry, the group permissions correspond to the permissions of
> + * the ACL_MASK entry. Otherwise, if the ACL has no ACL_MASK entry, the
> + * group permissions correspond to the permissions of the ACL_GROUP_OBJ
> + * entry.
> + *
> + * Use setfacl to check whether inode strip S_ISGID works correctly.
> + *
> + * Test for commit
> + * 1639a49ccdce ("fs: move S_ISGID stripping into the vfs_*() helpers").
> + */

This comment is pretty helpful and I'd like to see similar ones on top
of all the other tests you're adding. That would make it easier for
other to understand what's going on.

> +
> +static int setgid_create_acl(const struct vfstest_info *info)
> +{
> +	int fret = -1;
> +	int file1_fd = -EBADF;
> +	int tmpfile_fd = -EBADF;
> +	pid_t pid;
> +	bool supported = false;
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
> +	/* Verify that the setgid bit got raised. */
> +	if (!is_setgid(info->t_dir1_fd, "", AT_EMPTY_PATH)) {
> +		log_stderr("failure: is_setgid");
> +		goto out;
> +	}
> +
> +	supported = openat_tmpfile_supported(info->t_dir1_fd);
> +
> +	umask(S_IXGRP);
> +	mode = umask(S_IXGRP);
> +	if (!(mode & S_IXGRP))
> +		die("failure: umask");
> +
> +	pid = fork();
> +	if (pid < 0) {
> +		log_stderr("failure: fork");
> +		goto out;
> +	}
> +	if (pid == 0) {
> +		/* The group permissions correspond to the permissions of the
> +		 * ACL_MASK entry.
> +		 */

It wouldn't hurt to add a longer comment to these setfacl calls
detailing what you're trying to test exactly otherwise it may be hard
for other who are not familiar with ACLs what this does. :)

> +		snprintf(t_buf, sizeof(t_buf), "setfacl -d -m u::rwx,g::rw,o::rwx,m:rw %s/%s", info->t_mountpoint, T_DIR1);
> +		if (system(t_buf))
> +			die("failure: system");

Other than that this looks good!
Christian
