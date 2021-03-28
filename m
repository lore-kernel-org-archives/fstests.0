Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF6A3C433C1
	for <linux-fstests@archiver.kernel.org>; Sun, 28 Mar 2021 19:26:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD78C6195F
	for <linux-fstests@archiver.kernel.org>; Sun, 28 Mar 2021 19:26:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbhC1TZo (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 28 Mar 2021 15:25:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:52240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230184AbhC1TZi (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sun, 28 Mar 2021 15:25:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DA47E6195E;
        Sun, 28 Mar 2021 19:25:35 +0000 (UTC)
Date:   Sun, 28 Mar 2021 21:25:32 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Eryu Guan <guan@eryu.me>
Cc:     Christian Brauner <brauner@kernel.org>, fstests@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <djwong@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH v11 2/6] generic/632: add fstests for idmapped mounts
Message-ID: <20210328192532.jrw23brihkcrc6ok@wittgenstein>
References: <20210327111856.1211544-1-brauner@kernel.org>
 <20210327111856.1211544-3-brauner@kernel.org>
 <YGDL9EKPnPIcj6yh@desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YGDL9EKPnPIcj6yh@desktop>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Mar 29, 2021 at 02:33:24AM +0800, Eryu Guan wrote:
> On Sat, Mar 27, 2021 at 12:18:52PM +0100, Christian Brauner wrote:
> > From: Christian Brauner <christian.brauner@ubuntu.com>
> > 
> > Add a test suite to verify the behavior of idmapped mounts. The test
> > suite also includes a range of vfs tests to verify that no regressions
> > are introduced by idmapped mounts. The following tests are currently
> > available with more to come in the future:
> > 
> > 01. posix acls on regular and idmapped mounts
> > 02. create operations in user namespace
> > 03. device node creation in user namespace
> > 04. expected ownership on idmapped mounts
> > 05. fscaps on regular mounts
> > 06. fscaps on idmapped mounts
> > 07. fscaps on idmapped mounts in user namespace
> > 08. fscaps on idmapped mounts in user namespace
> >     with different id mappings
> > 09. mapped fsids
> > 10. unmapped fsids
> > 11. cross mount hardlink
> > 12. cross idmapped mount hardlink
> > 13. hardlinks from idmapped mounts
> > 14. hardlinks from idmapped mounts in user namespace
> > 15. io_uring
> > 16. io_uring in user namespace
> > 17. io_uring from idmapped mounts
> > 18. io_uring from idmapped mounts in user namespace
> > 19. io_uring from idmapped mounts with unmapped ids
> > 20. io_uring from idmapped mounts with unmapped ids in user namespace
> > 21. following protected symlinks on regular mounts
> > 22. following protected symlinks on idmapped mounts
> > 23. following protected symlinks on idmapped mounts in user namespace
> > 24. cross mount rename
> > 25. cross idmapped mount rename
> > 26. rename from idmapped mounts
> > 27. rename from idmapped mounts in user namespace
> > 28. symlink from regular mounts
> > 29. symlink from idmapped mounts
> > 30. symlink from idmapped mounts in user namespace
> > 31. setid binaries on regular mounts
> > 32. setid binaries on idmapped mounts
> > 33. setid binaries on idmapped mounts in user namespace
> > 34. setid binaries on idmapped mounts in user namespace
> >     with different id mappings
> > 35. sticky bit unlink operations on regular mounts
> > 36. sticky bit unlink operations on idmapped mounts
> > 37. sticky bit unlink operations on idmapped mounts in user namespace
> > 38. sticky bit rename operations on regular mounts
> > 39. sticky bit rename operations on idmapped mounts
> > 40. sticky bit rename operations on idmapped mounts in user namespace
> > 41. create operations in directories with setgid bit set
> > 42. create operations in directories with setgid bit set
> >     on idmapped mounts
> > 43. create operations in directories with setgid bit set
> >     on idmapped mounts in user namespace
> > 44. verify create operations and ownership with racing threads idmapping
> >     a mount
> > 45. setattr truncate operations on regular mounts
> > 46. setattr truncate operations on idmapped mounts
> > 47. setattr truncate operations on idmapped mounts in user namespace
> > 
> > Here's some sample output when running with DEBUG_TRACE defined:
> > 
> > Cc: Amir Goldstein <amir73il@gmail.com>
> > Cc: Eryu Guan <guan@eryu.me>
> > Cc: fstests@vger.kernel.org
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> > ---
> > /* v2 */ (send out alongside idmapped mounts patchset)
> > test-suite part of the kernel selftest framework
> > 
> > /* v3 */ (send out alongside idmapped mounts patchset)
> > patch introduced (ported form kernel selftest framework)
> > 
> > /* v4 */ (send out alongside idmapped mounts patchset)
> > - Amir Goldstein <amir73il@gmail.com>:
> >   - Don't Cc fstests mailing list on the testing patches for now.
> > 
> > - Add setgid creation tests.
> > 
> > /* v5 */ (send out alongside idmapped mounts patchset)
> > new base: 2080ad637bbb4d2c24c4d63939799dab178eb407
> > 
> > - Christoph Hellwig <hch@lst.de>:
> >   - Enable xfs testing.
> >   - Improve idmapped mount testing support.
> > 
> > - Christian Brauner <christian.brauner@ubuntu.com>:
> >   - Fix protected symlink tests.
> >   - Introduce xfs specific helpers.
> >   - Expand setgid bit tests to xfs.
> > 
> > /* v6 */ (send out alongside idmapped mounts patchset)
> > - Christian Brauner <christian.brauner@ubuntu.com>:
> >   - After Christoph fixed setgid handling on xfs remove all xfs specific
> >     parts apart from irix_sgid_inheritance checking.
> >   - Add idmapped-mounts binary to .gitignore
> >   - Fix feature testing.
> >   - Add truncation tests.
> > 
> > /* v7 */ (sent out as a separate patchset)
> > new base: 011bfb01f7f9f8f37c01d0a1ae0b0ca28e96a4f5
> > - Christian Brauner <christian.brauner@ubuntu.com>:
> >   - Expand debugging options.
> > 
> > /* v8 */
> > - Christoph Hellwig <hch@lst.de>:
> >   - Use __supported_fs generic instead of explicitly listing ext4 and xfs.
> >   - Remove obsolete comment.
> > 
> > /* v9 */
> > - Christian Brauner <christian.brauner@ubuntu.com>:
> >   - Rebase on current master.
> > 
> > /* v10 */
> > unchanged
> > 
> > /* v11 */
> > - Amir Goldstein <amir73il@gmail.com>:
> >   - Place "auto" and "quick" tags first for easier "eye grepping".
> >   - Add a dedicated "idmapped" tag for idmapped mounts tests.
> > ---
> >  .gitignore                            |    1 +
> >  common/rc                             |   25 +
> >  configure.ac                          |    2 +
> >  include/builddefs.in                  |    1 +
> >  m4/Makefile                           |    1 +
> >  m4/package_libcap.m4                  |    4 +
> >  src/Makefile                          |    5 +
> >  src/detached_mounts_propagation.c     |   65 +-
> >  src/feature.c                         |   40 +-
> >  src/idmapped-mounts/Makefile          |   35 +
> >  src/idmapped-mounts/idmapped-mounts.c | 8761 +++++++++++++++++++++++++
> >  src/idmapped-mounts/missing.h         |  151 +
> >  src/idmapped-mounts/utils.c           |  134 +
> >  src/idmapped-mounts/utils.h           |   29 +
> >  tests/generic/632                     |   42 +
> >  tests/generic/632.out                 |    2 +
> >  tests/generic/group                   |    1 +
> >  17 files changed, 9231 insertions(+), 68 deletions(-)
> >  create mode 100644 m4/package_libcap.m4
> >  create mode 100644 src/idmapped-mounts/Makefile
> >  create mode 100644 src/idmapped-mounts/idmapped-mounts.c
> >  create mode 100644 src/idmapped-mounts/missing.h
> >  create mode 100644 src/idmapped-mounts/utils.c
> >  create mode 100644 src/idmapped-mounts/utils.h
> >  create mode 100644 tests/generic/632
> >  create mode 100644 tests/generic/632.out
> > 
> 
> [snip]
> 
> > +
> > +/* caps_down - lower all effective caps */
> > +static int caps_down(void)
> > +{
> > +	bool fret = false;
> 
> When HAVE_SYS_CAPABILITY_H is not defined, i.e. libcap-devel package is
> not installed, so this causes test fails as
> 
> @@ -1,2 +1,7 @@
>  QA output created by 632
>  Silence is golden
> +idmapped-mounts.c: 419: switch_userns - Success - failure: caps_down
> +idmapped-mounts.c: 6617: acls - Success - failure: switch_userns
> +idmapped-mounts.c: 6627: acls - Success - failure: wait_for_pid
> +failure: posix acls on regular mounts
> +idmapped-mounts.c: 805: test_cleanup - Directory not empty - failure: rm_r
> 
> Also, please update README to add libcap-devel to "install prerequisite
> packages" list.
> 
> And it seems some tests depend on caps_down(), like io_uring tests, it
> depends on caps_down() to drop caps and expect EPERM. It'd be better to
> make libcap-devel optional and don't fail other tests if it's not
> installed.

Ok, fixing this now.

> 
> > +#ifdef HAVE_SYS_CAPABILITY_H
> > +	cap_t caps = NULL;
> > +	int ret = -1;
> > +
> > +	caps = cap_get_proc();
> > +	if (!caps)
> > +		goto out;
> > +
> > +	ret = cap_clear_flag(caps, CAP_EFFECTIVE);
> > +	if (ret)
> > +		goto out;
> > +
> > +	ret = cap_set_proc(caps);
> > +	if (ret)
> > +		goto out;
> > +
> > +	fret = true;
> > +
> > +out:
> > +	cap_free(caps);
> > +#endif
> > +	return fret;
> > +}
> > +
> > +/* caps_down - raise all permitted caps */
> 
> caps_up

Thanks for catching this!

> 
> > +static int caps_up(void)
> 
> [snip]
> 
> > +static int print_r(int fd, const char *path)
> 
> I saw build warnings:
> 
> idmapped-mounts.c:554:12: warning: 'print_r' defined but not used [-Wunused-function]
>   554 | static int print_r(int fd, const char *path)
>       |            ^~~~~~~
> 
> because DEBUG_TRACE is not defined.

Fixed.

Christian
