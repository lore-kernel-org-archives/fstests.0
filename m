Received: from mail-lf0-f65.google.com ([209.85.215.65]:33598 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750853AbdCHMRg (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 8 Mar 2017 07:17:36 -0500
Received: by mail-lf0-f65.google.com with SMTP id r36so2245562lfi.0
        for <fstests@vger.kernel.org>; Wed, 08 Mar 2017 04:16:43 -0800 (PST)
From: Dmitry Monakhov <dmonakhov@openvz.org>
Subject: Re: [PATCH 2/2] report: Add xunit format report generator
In-Reply-To: <20170308030023.GW14226@eguan.usersys.redhat.com>
References: <1488529576-17034-1-git-send-email-dmonakhov@openvz.org> <1488529576-17034-3-git-send-email-dmonakhov@openvz.org> <20170307120534.GV14226@eguan.usersys.redhat.com> <CAOQ4uxggR96taZ0Bs3JnNEU-YW6f1QO9t2MDHiThc2DOLHcQ3A@mail.gmail.com> <20170308030023.GW14226@eguan.usersys.redhat.com>
Date: Wed, 08 Mar 2017 15:16:39 +0300
Message-ID: <87shmo6k0o.fsf@dmlp.sw.ru>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>, Amir Goldstein <amir73il@gmail.com>
Cc: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

Eryu Guan <eguan@redhat.com> writes:

> On Tue, Mar 07, 2017 at 03:13:01PM +0200, Amir Goldstein wrote:
>> On Tue, Mar 7, 2017 at 2:05 PM, Eryu Guan <eguan@redhat.com> wrote:
>> > On Fri, Mar 03, 2017 at 12:26:16PM +0400, Dmitry Monakhov wrote:
>> >> xunit[1]/junit[2] are well known report formats for tests frameworks which
>> >> supported by most of test CI frameworks(such as Jenkins [3], Bamboo [4], Avocado [5])
>> >> Basically this is just xml document which can be easily parsed later by external tools.
>> >>
>> >> changes since v2: (in response to eguan@)
>> >>  - assert repot format on initialization
>> >>  - Tabify new files
>> >>
>> >> changes since v1:
>> >>  - Use generic '-R fmt' option for report generation, asked by eguan@
>> >>  - localize variables, asked by eguan@
>> >>  - do not add empty files to report asked by eguan@
>> >>  - Add properties
>> >>  - Fix system-err/system-out node nesting
>> >>
>> >> EXAMPLE:
>> >> #./check -R xunit -s ext4 generic/001 generic/010
>> >> #cat results/ext4/result.xml
>> >> <?xml version="1.0" encoding="UTF-8"?>
>> >> <testsuite name="xfstests" errors="0" skipped="1" tests="2" time="7"  hostname="alice" timestamp="2017-02-21T15:15:06"  >
>> >>       <properties>
>> >>               <property name="SECTION" value="ext4"/>
>> >>               <property name="FSTYP" value="ext4"/>
>> >>               <property name="MOUNT_OPTIONS" value="-o acl,user_xattr "/>
>> >>               <property name="HOST_OPTIONS" value="/devel/xfstests-dev.git/configs/alice.config"/>
>> >>               <property name="XFS_MKFS_OPTIONS" value="-bsize=4096"/>
>> >>               <property name="TIME_FACTOR" value="1"/>
>> >>               <property name="LOAD_FACTOR" value="1"/>
>> >>               <property name="TEST_DIR" value="/mnt/test"/>
>> >>               <property name="TEST_DEV" value="/dev/ram0"/>
>> >>               <property name="SCRATCH_DEV" value="/dev/ram1"/>
>> >>               <property name="SCRATCH_MNT" value="/mnt/scratch"/>
>> >>               <property name="OVERLAY_UPPER_DIR" value="upper"/>
>> >>               <property name="OVERLAY_LOWER_DIR" value="lower"/>
>> >>               <property name="OVERLAY_WORK_DIR" value="work"/>
>> >>       </properties>
>> >>       <testcase classname="xfstests.ext4" name="generic/001" time="5">
>> >>       </testcase>
>> >>       <testcase classname="xfstests.ext4" name="generic/010" time="1">
>> >>               <skipped message="src/dbtest not built" />
>> >>       </testcase>
>> >> </testsuite>
>> >>
>> >> Footnotes:
>> >> [1] https://xunit.github.io/docs/format-xml-v2.html
>> >> [2] http://help.catchsoftware.com/display/ET/JUnit+Format
>> >> [3] https://jenkins.io
>> >> [4] https://www.atlassian.com/software/bamboo
>> >> [5] https://github.com/avocado-framework/avocado
>> >>
>> >> Signed-off-by: Dmitry Monakhov <dmonakhov@openvz.org>
>> >
>> > I renamed OVERLAY_{UPPER,LOWER,WORK}_DIR to OVL_{UPPER,LOWER,WORK} in
>> > this patch, as they've been updated by recent overlayfs patch.
>> >
>> 
>> I would prefer if those were not configuration options at all.
>> 
>> As I wrote in commit 6f5ba68b:
>> 
>>     - Make those vars values non-configurable, because lower/upper/work
>>       directory names are an internal test detail which should
>>       not concern the user and because we wish to simplify
>>       and document the overlay tests setup
>
> Thanks for the reminder!
>
> Dmitry, do you mind I removing all these overlay variables from
> REPORT_ENV_LIST?
Off course. Please.
This list should contains only externally configurable options necessery for
later reproduction.

>
> Thanks,
> Eryu
