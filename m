Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D32BC433DB
	for <linux-fstests@archiver.kernel.org>; Sun, 28 Mar 2021 18:35:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5408B61966
	for <linux-fstests@archiver.kernel.org>; Sun, 28 Mar 2021 18:35:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231149AbhC1SfX (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 28 Mar 2021 14:35:23 -0400
Received: from out20-74.mail.aliyun.com ([115.124.20.74]:44884 "EHLO
        out20-74.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230514AbhC1SfO (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 28 Mar 2021 14:35:14 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.0836765|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.278701-0.000775083-0.720524;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047192;MF=guan@eryu.me;NM=1;PH=DS;RN=6;RT=6;SR=0;TI=SMTPD_---.JrchbO8_1616956512;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.JrchbO8_1616956512)
          by smtp.aliyun-inc.com(10.147.43.230);
          Mon, 29 Mar 2021 02:35:12 +0800
Date:   Mon, 29 Mar 2021 02:35:12 +0800
From:   Eryu Guan <guan@eryu.me>
To:     Christian Brauner <brauner@kernel.org>
Cc:     fstests@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <djwong@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: [PATCH v11 3/6] common/rc: add _scratch_{u}mount_idmapped()
 helpers
Message-ID: <YGDMYBu0NGhHR+/f@desktop>
References: <20210327111856.1211544-1-brauner@kernel.org>
 <20210327111856.1211544-4-brauner@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210327111856.1211544-4-brauner@kernel.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sat, Mar 27, 2021 at 12:18:53PM +0100, Christian Brauner wrote:
> From: Christian Brauner <christian.brauner@ubuntu.com>
> 
> They will be used in follow-up patches for xfs quota tests but might be
> useful for other tests in the future.
> 
> Cc: Eryu Guan <guan@eryu.me>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: David Howells <dhowells@redhat.com>
> Cc: fstests@vger.kernel.org
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> ---
> /* v1 - v9 */
> patch not present
> 
> /* v10 */
> patch introduced
> 
> /* v11 */
> - Amir Goldstein <amir73il@gmail.com>:
>   - Minor Makefile style nit.
>   - Add missing "/" when calculating maxium path length.
>   - Handle the case where user gives us a path to userns.
> ---
>  .gitignore                           |   1 +
>  common/rc                            |  35 +++
>  src/idmapped-mounts/Makefile         |  14 +-
>  src/idmapped-mounts/mount-idmapped.c | 431 +++++++++++++++++++++++++++
>  src/idmapped-mounts/utils.c          |   2 +-
>  src/idmapped-mounts/utils.h          |   1 +
>  6 files changed, 479 insertions(+), 5 deletions(-)
>  create mode 100644 src/idmapped-mounts/mount-idmapped.c
> 
> diff --git a/.gitignore b/.gitignore
> index 3229bb26..4cc9c807 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -179,6 +179,7 @@
>  /src/aio-dio-regress/aiocp
>  /src/aio-dio-regress/aiodio_sparse2
>  /src/idmapped-mounts/idmapped-mounts
> +/src/idmapped-mounts/mount-idmapped
>  /src/log-writes/replay-log
>  /src/perf/*.pyc
>  
> diff --git a/common/rc b/common/rc
> index a8b375a2..351996fc 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -342,6 +342,36 @@ _scratch_mount()
>  	_try_scratch_mount $* || _fail "mount failed"
>  }
>  
> +_scratch_mount_idmapped()
> +{
> +	local type="$1"
> +	local id="$2"
> +
> +	if [ "$type" = "u" ]; then
> +		# This means root will be able to create files as uid %id in
> +		# the underlying filesystem by going through the idmapped mount.
> +		$here/src/idmapped-mounts/mount-idmapped --map-mount u:0:$id:1 \
> +							 --map-mount u:$id:0:1 \
> +							 --map-mount g:0:0:1 \
> +							 "$SCRATCH_MNT" "$SCRATCH_MNT" || _fail "mount-idmapped failed"
> +	elif [ "$type" = "g" ]; then
> +		# This means root will be able to create files as gid %id in
> +		# the underlying filesystem by going through the idmapped mount.
> +		$here/src/idmapped-mounts/mount-idmapped --map-mount g:0:$id:1 \
> +							 --map-mount g:$id:0:1 \
> +							 --map-mount u:0:0:1 \
> +							 "$SCRATCH_MNT" "$SCRATCH_MNT" || _fail "mount-idmapped failed"
> +	elif [ "$type" = "b" ]; then
> +		# This means root will be able to create files as uid and gid
> +		# %id in the underlying filesystem by going through the idmapped mount.
> +		$here/src/idmapped-mounts/mount-idmapped --map-mount b:0:$id:1 \
> +							 --map-mount b:$id:0:1 \
> +							 "$SCRATCH_MNT" "$SCRATCH_MNT" || _fail "mount-idmapped failed"
> +	else
> +		_fail "usage: either \"u\" (uid), \"g\" (gid), or \"b\" (uid and gid) must be specified "
> +	fi
> +}
> +
>  _scratch_unmount()
>  {
>  	case "$FSTYP" in
> @@ -357,6 +387,11 @@ _scratch_unmount()
>  	esac
>  }
>  
> +_scratch_umount_idmapped()
> +{
> +	$UMOUNT_PROG $SCRATCH_MNT
> +}
> +
>  _scratch_remount()
>  {
>      local opts="$1"
> diff --git a/src/idmapped-mounts/Makefile b/src/idmapped-mounts/Makefile
> index 6a934146..b2bff854 100644
> --- a/src/idmapped-mounts/Makefile
> +++ b/src/idmapped-mounts/Makefile
> @@ -3,9 +3,10 @@
>  TOPDIR = ../..
>  include $(TOPDIR)/include/builddefs
>  
> -TARGETS = idmapped-mounts
> +TARGETS = idmapped-mounts mount-idmapped
> +CFILES_IDMAPPED_MOUNTS = idmapped-mounts.c utils.c
> +CFILES_MOUNT_IDMAPPED = mount-idmapped.c utils.c
>  
> -CFILES = idmapped-mounts.c utils.c
>  HFILES = missing.h utils.h
>  LLDLIBS += -pthread
>  LDIRT = $(TARGETS)
> @@ -24,12 +25,17 @@ depend: .dep
>  
>  include $(BUILDRULES)
>  
> -$(TARGETS): $(CFILES)
> +idmapped-mounts: $(CFILES_IDMAPPED_MOUNTS)
>  	@echo "    [CC]    $@"
> -	$(Q)$(LTLINK) $(CFILES) -o $@ $(CFLAGS) $(LDFLAGS) $(LDLIBS)
> +	$(Q)$(LTLINK) $(CFILES_IDMAPPED_MOUNTS) -o $@ $(CFLAGS) $(LDFLAGS) $(LDLIBS)
> +
> +mount-idmapped: $(CFILES_MOUNT_IDMAPPED)
> +	@echo "    [CC]    $@"
> +	$(Q)$(LTLINK) $(CFILES_MOUNT_IDMAPPED) -o $@ $(CFLAGS) $(LDFLAGS) $(LDLIBS)
>  
>  install:
>  	$(INSTALL) -m 755 -d $(PKG_LIB_DIR)/src/idmapped-mounts
>  	$(INSTALL) -m 755 $(TARGETS) $(PKG_LIB_DIR)/src/idmapped-mounts
> +	$(INSTALL) -m 755 $(TARGETS) $(PKG_LIB_DIR)/src/mount-idmapped

This is not needed, and causes 'Make install' failure

/usr/bin/gmake -C idmapped-mounts install
../../install-sh -o root -g root -m 755 -d /var/lib/xfstests/src/idmapped-mounts
../../install-sh -o root -g root -m 755 idmapped-mounts mount-idmapped /var/lib/xfstests/src/idmapped-mounts
../../install-sh -o root -g root -m 755 idmapped-mounts mount-idmapped /var/lib/xfstests/src/mount-idmapped
chmod: cannot access '//var/lib/xfstests/src/mount-idmapped/idmapped-mounts': Not a directory
gmake[2]: *** [Makefile:39: install] Error 1

Thanks,
Eryu
