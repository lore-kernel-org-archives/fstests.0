Received: from mx1.redhat.com ([209.132.183.28]:55458 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755181AbdCGMao (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 7 Mar 2017 07:30:44 -0500
Date: Tue, 7 Mar 2017 20:05:34 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH 2/2] report: Add xunit format report generator
Message-ID: <20170307120534.GV14226@eguan.usersys.redhat.com>
References: <1488529576-17034-1-git-send-email-dmonakhov@openvz.org>
 <1488529576-17034-3-git-send-email-dmonakhov@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1488529576-17034-3-git-send-email-dmonakhov@openvz.org>
Sender: fstests-owner@vger.kernel.org
To: Dmitry Monakhov <dmonakhov@openvz.org>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri, Mar 03, 2017 at 12:26:16PM +0400, Dmitry Monakhov wrote:
> xunit[1]/junit[2] are well known report formats for tests frameworks which
> supported by most of test CI frameworks(such as Jenkins [3], Bamboo [4], Avocado [5])
> Basically this is just xml document which can be easily parsed later by external tools.
> 
> changes since v2: (in response to eguan@)
>  - assert repot format on initialization
>  - Tabify new files
> 
> changes since v1:
>  - Use generic '-R fmt' option for report generation, asked by eguan@
>  - localize variables, asked by eguan@
>  - do not add empty files to report asked by eguan@
>  - Add properties
>  - Fix system-err/system-out node nesting
> 
> EXAMPLE:
> #./check -R xunit -s ext4 generic/001 generic/010
> #cat results/ext4/result.xml
> <?xml version="1.0" encoding="UTF-8"?>
> <testsuite name="xfstests" errors="0" skipped="1" tests="2" time="7"  hostname="alice" timestamp="2017-02-21T15:15:06"  >
> 	<properties>
> 		<property name="SECTION" value="ext4"/>
> 		<property name="FSTYP" value="ext4"/>
> 		<property name="MOUNT_OPTIONS" value="-o acl,user_xattr "/>
> 		<property name="HOST_OPTIONS" value="/devel/xfstests-dev.git/configs/alice.config"/>
> 		<property name="XFS_MKFS_OPTIONS" value="-bsize=4096"/>
> 		<property name="TIME_FACTOR" value="1"/>
> 		<property name="LOAD_FACTOR" value="1"/>
> 		<property name="TEST_DIR" value="/mnt/test"/>
> 		<property name="TEST_DEV" value="/dev/ram0"/>
> 		<property name="SCRATCH_DEV" value="/dev/ram1"/>
> 		<property name="SCRATCH_MNT" value="/mnt/scratch"/>
> 		<property name="OVERLAY_UPPER_DIR" value="upper"/>
> 		<property name="OVERLAY_LOWER_DIR" value="lower"/>
> 		<property name="OVERLAY_WORK_DIR" value="work"/>
> 	</properties>
> 	<testcase classname="xfstests.ext4" name="generic/001" time="5">
> 	</testcase>
> 	<testcase classname="xfstests.ext4" name="generic/010" time="1">
> 		<skipped message="src/dbtest not built" />
> 	</testcase>
> </testsuite>
> 
> Footnotes:
> [1] https://xunit.github.io/docs/format-xml-v2.html
> [2] http://help.catchsoftware.com/display/ET/JUnit+Format
> [3] https://jenkins.io
> [4] https://www.atlassian.com/software/bamboo
> [5] https://github.com/avocado-framework/avocado
> 
> Signed-off-by: Dmitry Monakhov <dmonakhov@openvz.org>

I renamed OVERLAY_{UPPER,LOWER,WORK}_DIR to OVL_{UPPER,LOWER,WORK} in
this patch, as they've been updated by recent overlayfs patch.

I also fixed some minor indention issues and removed unused test_status
in _assert_report_list() function.

Thanks for the update!

Eryu
