Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4D88C4707A
	for <linux-fstests@archiver.kernel.org>; Sun, 23 May 2021 15:07:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EB75611ED
	for <linux-fstests@archiver.kernel.org>; Sun, 23 May 2021 15:07:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231821AbhEWPIl (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 23 May 2021 11:08:41 -0400
Received: from out20-99.mail.aliyun.com ([115.124.20.99]:36077 "EHLO
        out20-99.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231812AbhEWPIl (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 23 May 2021 11:08:41 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07436284|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.413562-0.00393565-0.582502;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047205;MF=guan@eryu.me;NM=1;PH=DS;RN=4;RT=4;SR=0;TI=SMTPD_---.KHcBwzY_1621782431;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.KHcBwzY_1621782431)
          by smtp.aliyun-inc.com(10.147.41.187);
          Sun, 23 May 2021 23:07:11 +0800
Date:   Sun, 23 May 2021 23:07:05 +0800
From:   Eryu Guan <guan@eryu.me>
To:     Christian Brauner <brauner@kernel.org>
Cc:     fstests@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: [PATCH 4/7] generic/637: add fscaps regression test
Message-ID: <YKpvmcltp8FF8KJR@desktop>
References: <20210507150100.968659-1-brauner@kernel.org>
 <20210507150100.968659-5-brauner@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210507150100.968659-5-brauner@kernel.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, May 07, 2021 at 05:00:57PM +0200, Christian Brauner wrote:
> From: Christian Brauner <christian.brauner@ubuntu.com>
> 
> Add a test to verify that setting a v3 fscap from an idmapped mount
> works as expected. This and other related use-cases were regressed by
> commit [1] which was reverted in [2] and the proper fix merged right
> before v5.12 was released in [3].
> 
> [1]: commit 3b0c2d3eaa83 ("Revert 95ebabde382c ("capabilities: Don't allow writing ambiguous v3 file capabilities")")
> [2]: commit 95ebabde382c ("capabilities: Don't allow writing ambiguous v3 file capabilities")
> [3]: commit db2e718a4798 ("capabilities: require CAP_SETFCAP to map uid 0")
> Cc: fstests@vger.kernel.org
> Cc: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>

Sorry for the late review..

> ---
>  .gitignore                            |   1 +
>  src/idmapped-mounts/Makefile          |  12 ++-
>  src/idmapped-mounts/idmapped-mounts.c | 135 +++++++++++++++++++++++++-
>  tests/generic/637                     |  42 ++++++++
>  tests/generic/637.out                 |   2 +
>  tests/generic/group                   |   1 +
>  6 files changed, 188 insertions(+), 5 deletions(-)
>  create mode 100755 tests/generic/637
>  create mode 100644 tests/generic/637.out
> 
> diff --git a/.gitignore b/.gitignore
> index 4cc9c807..da48e6f8 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -180,6 +180,7 @@
>  /src/aio-dio-regress/aiodio_sparse2
>  /src/idmapped-mounts/idmapped-mounts
>  /src/idmapped-mounts/mount-idmapped
> +/src/idmapped-mounts/fscaps-in-ancestor-userns
>  /src/log-writes/replay-log
>  /src/perf/*.pyc
>  
> diff --git a/src/idmapped-mounts/Makefile b/src/idmapped-mounts/Makefile
> index ad4ddc99..1bab6471 100644
> --- a/src/idmapped-mounts/Makefile
> +++ b/src/idmapped-mounts/Makefile
> @@ -3,7 +3,9 @@
>  TOPDIR = ../..
>  include $(TOPDIR)/include/builddefs
>  
> -TARGETS = idmapped-mounts mount-idmapped
> +BINS = idmapped-mounts mount-idmapped
> +LINKS = fscaps-in-ancestor-userns
> +TARGETS = $(BINS) $(LINKS)
>  CFILES_IDMAPPED_MOUNTS = idmapped-mounts.c utils.c
>  CFILES_MOUNT_IDMAPPED = mount-idmapped.c utils.c
>  
> @@ -29,12 +31,18 @@ idmapped-mounts: $(CFILES_IDMAPPED_MOUNTS)
>  	@echo "    [CC]    $@"
>  	$(Q)$(LTLINK) $(CFILES_IDMAPPED_MOUNTS) -o $@ $(CFLAGS) $(LDFLAGS) $(LDLIBS)
>  
> +fscaps-in-ancestor-userns:
> +	ln -sf idmapped-mounts fscaps-in-ancestor-userns
> +
>  mount-idmapped: $(CFILES_MOUNT_IDMAPPED)
>  	@echo "    [CC]    $@"
>  	$(Q)$(LTLINK) $(CFILES_MOUNT_IDMAPPED) -o $@ $(CFLAGS) $(LDFLAGS) $(LDLIBS)
>  
>  install:
>  	$(INSTALL) -m 755 -d $(PKG_LIB_DIR)/src/idmapped-mounts
> -	$(INSTALL) -m 755 $(TARGETS) $(PKG_LIB_DIR)/src/idmapped-mounts
> +	$(INSTALL) -m 755 $(BINS) $(PKG_LIB_DIR)/src/idmapped-mounts
> +	cd $(PKG_LIB_DIR)/src/idmapped-mounts && \
> +		rm -f $(LINKS) && \
> +		$(LN_S) idmapped-mounts fscaps-in-ancestor-userns
>  
>  -include .dep
> diff --git a/src/idmapped-mounts/idmapped-mounts.c b/src/idmapped-mounts/idmapped-mounts.c
> index 4d93b721..94b83c01 100644
> --- a/src/idmapped-mounts/idmapped-mounts.c
> +++ b/src/idmapped-mounts/idmapped-mounts.c
> @@ -3201,6 +3201,121 @@ out:
>  	return fret;
>  }
>  
> +static int fscaps_idmapped_mounts_in_userns_valid_in_ancestor_userns(void)
> +{
> +	int fret = -1;
> +	int file1_fd = -EBADF, file1_fd2 = -EBADF, open_tree_fd = -EBADF;
> +	struct mount_attr attr = {
> +		.attr_set = MOUNT_ATTR_IDMAP,
> +	};
> +	pid_t pid;
> +
> +	file1_fd = openat(t_dir1_fd, FILE1, O_CREAT | O_EXCL | O_CLOEXEC, 0644);
> +	if (file1_fd < 0) {
> +		log_stderr("failure: openat");
> +		goto out;
> +	}
> +
> +	/* Skip if vfs caps are unsupported. */
> +	if (set_dummy_vfs_caps(file1_fd, 0, 1000))
> +		return 0;
> +
> +	if (fremovexattr(file1_fd, "security.capability")) {
> +		log_stderr("failure: fremovexattr");
> +		goto out;
> +	}
> +	if (expected_dummy_vfs_caps_uid(file1_fd, -1)) {
> +		log_stderr("failure: expected_dummy_vfs_caps_uid");
> +		goto out;
> +	}
> +	if (errno != ENODATA) {
> +		log_stderr("failure: errno");
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
> +	open_tree_fd = sys_open_tree(t_dir1_fd, "",
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
> +	file1_fd2 = openat(open_tree_fd, FILE1, O_RDWR | O_CLOEXEC, 0);
> +	if (file1_fd2 < 0) {
> +		log_stderr("failure: openat");
> +		goto out;
> +	}
> +
> +	/*
> +	 * Verify we can set an v3 fscap for real root this was regressed at
> +	 * some point. Make sure this doesn't happen again!
> +	 */
> +	pid = fork();
> +	if (pid < 0) {
> +		log_stderr("failure: fork");
> +		goto out;
> +	}
> +	if (pid == 0) {
> +		if (!switch_userns(attr.userns_fd, 0, 0, false))
> +			die("failure: switch_userns");
> +
> +		if (expected_dummy_vfs_caps_uid(file1_fd2, -1))
> +			die("failure: expected_dummy_vfs_caps_uid");
> +		if (errno != ENODATA)
> +			die("failure: errno");
> +
> +		if (set_dummy_vfs_caps(file1_fd2, 0, 0))
> +			die("failure: set_dummy_vfs_caps");
> +
> +		if (!expected_dummy_vfs_caps_uid(file1_fd2, 0))
> +			die("failure: expected_dummy_vfs_caps_uid");
> +
> +		if (!expected_dummy_vfs_caps_uid(file1_fd, 0) && errno != EOVERFLOW)
> +			die("failure: expected_dummy_vfs_caps_uid");
> +
> +		exit(EXIT_SUCCESS);
> +	}
> +
> +	if (wait_for_pid(pid))
> +		goto out;
> +
> +	if (!expected_dummy_vfs_caps_uid(file1_fd2, 10000)) {
> +		log_stderr("failure: expected_dummy_vfs_caps_uid");
> +		goto out;
> +	}
> +
> +	if (!expected_dummy_vfs_caps_uid(file1_fd, 0)) {
> +		log_stderr("failure: expected_dummy_vfs_caps_uid");
> +		goto out;
> +	}
> +
> +	fret = 0;
> +	log_debug("Ran test");
> +out:
> +	safe_close(attr.userns_fd);
> +	safe_close(file1_fd);
> +	safe_close(file1_fd2);
> +	safe_close(open_tree_fd);
> +
> +	return fret;
> +}
> +
>  static int fscaps_idmapped_mounts_in_userns_separate_userns(void)
>  {
>  	int fret = -1;
> @@ -8745,7 +8860,7 @@ struct t_idmapped_mounts {
>  	{ fscaps,							"fscaps on regular mounts",									},
>  	{ fscaps_idmapped_mounts,					"fscaps on idmapped mounts",									},
>  	{ fscaps_idmapped_mounts_in_userns,				"fscaps on idmapped mounts in user namespace",							},
> -	{ fscaps_idmapped_mounts_in_userns_separate_userns,		"fscaps on idmapped mounts in user namespace with different id mappings ",			},
> +	{ fscaps_idmapped_mounts_in_userns_separate_userns,		"fscaps on idmapped mounts in user namespace with different id mappings",			},
>  	{ fsids_mapped,							"mapped fsids",											},
>  	{ fsids_unmapped,						"unmapped fsids",										},
>  	{ hardlink_crossing_mounts,					"cross mount hardlink",										},
> @@ -8789,6 +8904,10 @@ struct t_idmapped_mounts {
>  	{ threaded_idmapped_mount_interactions,				"threaded operations on idmapped mounts",							},
>  };
>  
> +struct t_idmapped_mounts fscaps_in_ancestor_userns[] = {
> +	{ fscaps_idmapped_mounts_in_userns_valid_in_ancestor_userns,	"fscaps on idmapped mounts in user namespace writing fscap valid in ancestor userns",		},
> +};
> +
>  static bool run_test(struct t_idmapped_mounts suite[], size_t suite_size)
>  {
>  	int i;
> @@ -8826,6 +8945,7 @@ static bool run_test(struct t_idmapped_mounts suite[], size_t suite_size)
>  
>  int main(int argc, char *argv[])
>  {
> +	const char *invocation_name;
>  	int fret, ret;
>  	int index = 0;
>  	bool supported = false;
> @@ -8913,8 +9033,17 @@ int main(int argc, char *argv[])
>  
>  	fret = EXIT_FAILURE;
>  
> -	if (!run_test(basic_suite, ARRAY_SIZE(basic_suite)))
> -		goto out;
> +	invocation_name = basename(argv[0]);
> +	if (strcmp(invocation_name, "idmapped-mounts") == 0) {
> +		if (!run_test(basic_suite, ARRAY_SIZE(basic_suite)))
> +			goto out;
> +	} else if (strcmp(invocation_name, "fscaps-in-ancestor-userns") == 0) {

I think there's no need to create symlink for each new test and use
different invocation name to run the new test. How about always using
the idmapped-mounts binary, just introduce a new option to specify which
test group to run? e.g. introduce a "-t" option and run

./idmapped-mounts -t basic_suite # for existing tests, and
./idmapped-mounts -t fscaps_in_ancester_userns # for this new test

Thanks,
Eryu

> +		if (!run_test(fscaps_in_ancestor_userns,
> +			      ARRAY_SIZE(fscaps_in_ancestor_userns)))
> +			goto out;
> +	} else {
> +		die("idmapped mount test suite \"%s\" unknown", invocation_name);
> +	}
>  
>  	fret = EXIT_SUCCESS;
>  
> diff --git a/tests/generic/637 b/tests/generic/637
> new file mode 100755
> index 00000000..25c601b5
> --- /dev/null
> +++ b/tests/generic/637
> @@ -0,0 +1,42 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2021 Christian Brauner.  All Rights Reserved.
> +#
> +# FS QA Test 637
> +#
> +# Test that fscaps on idmapped mounts behave correctly.
> +#
> +seq=`basename $0`
> +seqres=$RESULT_DIR/$seq
> +echo "QA output created by $seq"
> +
> +here=`pwd`
> +tmp=/tmp/$$
> +status=1	# failure is the default!
> +trap "_cleanup; exit \$status" 0 1 2 3 15
> +
> +_cleanup()
> +{
> +	cd /
> +	rm -f $tmp.*
> +}
> +
> +# get standard environment, filters and checks
> +. ./common/rc
> +. ./common/filter
> +
> +# remove previous $seqres.full before test
> +rm -f $seqres.full
> +
> +# real QA test starts here
> +
> +_supported_fs generic
> +_require_idmapped_mounts
> +_require_test
> +
> +echo "Silence is golden"
> +
> +$here/src/idmapped-mounts/fscaps-in-ancestor-userns --device "$TEST_DEV" --mount "$TEST_DIR" --fstype "$FSTYP"
> +
> +status=$?
> +exit
> diff --git a/tests/generic/637.out b/tests/generic/637.out
> new file mode 100644
> index 00000000..55a3d825
> --- /dev/null
> +++ b/tests/generic/637.out
> @@ -0,0 +1,2 @@
> +QA output created by 637
> +Silence is golden
> diff --git a/tests/generic/group b/tests/generic/group
> index 105763c4..9dfefdf4 100644
> --- a/tests/generic/group
> +++ b/tests/generic/group
> @@ -639,3 +639,4 @@
>  634 auto quick atime bigtime
>  635 auto quick atime bigtime shutdown
>  636 auto quick swap
> +637 auto quick idmapped
> -- 
> 2.27.0
