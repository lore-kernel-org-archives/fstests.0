Received: from mail-oi0-f54.google.com ([209.85.218.54]:33707 "EHLO
        mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751256AbdDNOtt (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 14 Apr 2017 10:49:49 -0400
Received: by mail-oi0-f54.google.com with SMTP id b187so94087533oif.0
        for <fstests@vger.kernel.org>; Fri, 14 Apr 2017 07:49:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170414100134.iqqou7chjsctpfwh@XZHOUW.usersys.redhat.com>
References: <20170412062608.y2u5og3xz2oly44b@XZHOUW.usersys.redhat.com>
 <1492008380-29164-1-git-send-email-xzhou@redhat.com> <1492008380-29164-3-git-send-email-xzhou@redhat.com>
 <20170413041157.rcctxishunypgtvv@XZHOUW.usersys.redhat.com>
 <CAPcyv4iEk2BVq=W=Dd36Dfra7WD2LpGT0FV4afFU4HuOfzdFmQ@mail.gmail.com> <20170414100134.iqqou7chjsctpfwh@XZHOUW.usersys.redhat.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 14 Apr 2017 07:49:48 -0700
Message-ID: <CAPcyv4jbM2Kb4pZtyihrX=ZME+mTr5+vLN6PO-31o9jyaPPwMg@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] generic: test mmap io fom DAX to non-DAX
Content-Type: text/plain; charset=UTF-8
Sender: fstests-owner@vger.kernel.org
To: Xiong Zhou <xzhou@redhat.com>
Cc: fstests@vger.kernel.org, Ross Zwisler <ross.zwisler@linux.intel.com>, jmoyer <jmoyer@redhat.com>, Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

On Fri, Apr 14, 2017 at 3:01 AM, Xiong Zhou <xzhou@redhat.com> wrote:
> On Thu, Apr 13, 2017 at 06:36:34AM -0700, Dan Williams wrote:
>> On Wed, Apr 12, 2017 at 9:11 PM, Xiong Zhou <xzhou@redhat.com> wrote:
>> > On Wed, Apr 12, 2017 at 10:46:18PM +0800, Xiong Zhou wrote:
>> >> Mount TEST_DEV as non-DAX, SCRATCH_DEV as DAX, then
>> >> do mmap DIO from DAX to non-DAX.
>> >>
>> >> This test is split from generic/413. Since DIO from DAX
>> >> to non-DAX is only supported/doable when device underneath
>> >> has memory(struct page) backend.
>> >>
>> >> By ndctl looking at SCRATCH_DEV, skip this test if it is
>> >> not in "memory mode".
>> >>
>> >> Adding helper to check pmem device status, which requires new
>> >> PROGs ndctl to tweaking pmem devices and jq to parse ndctl's
>> >> JSON format outputs.
>> >>
>> >> Signed-off-by: Xiong Zhou <xzhou@redhat.com>
>> >> ---
>> >>  common/config         |   2 +
>> >>  common/rc             |  41 ++++++++++++++++++
>> >>  tests/generic/423     | 113 ++++++++++++++++++++++++++++++++++++++++++++++++++
>> >>  tests/generic/423.out |   2 +
>> >>  tests/generic/group   |   1 +
>> >>  5 files changed, 159 insertions(+)
>> >>  create mode 100755 tests/generic/423
>> >>  create mode 100644 tests/generic/423.out
>> >>
>> >> diff --git a/common/config b/common/config
>> >> index 59041a3..dfdcb8e 100644
>> >> --- a/common/config
>> >> +++ b/common/config
>> >> @@ -212,6 +212,8 @@ export XZ_PROG="`set_prog_path xz`"
>> >>  export FLOCK_PROG="`set_prog_path flock`"
>> >>  export LDD_PROG="`set_prog_path ldd`"
>> >>  export TIMEOUT_PROG="`set_prog_path timeout`"
>> >> +export NDCTL_PROG="`set_prog_path ndctl`"
>> >> +export JQ_PROG="`set_prog_path jq`"
>> >>
>> >>  # use 'udevadm settle' or 'udevsettle' to wait for lv to be settled.
>> >>  # newer systems have udevadm command but older systems like RHEL5 don't.
>> >> diff --git a/common/rc b/common/rc
>> >> index 78a2101..35b8f6a 100644
>> >> --- a/common/rc
>> >> +++ b/common/rc
>> >> @@ -3151,6 +3151,47 @@ _require_chattr()
>> >>       rm -f $TEST_DIR/syscalltest.out
>> >>  }
>> >>
>> >> +# Looking up pmem devices' arttributes in
>> >> +# `ndctl list` output like this:
>> >> +#  {
>> >> +#    "dev":"namespace2.0",
>> >> +#    "mode":"raw",
>> >> +#    "size":8589934592,
>> >> +#    "blockdev":"pmem2"
>> >> +#  },
>> >> +_ndctl_get_pmem_key_value()
>> >> +{
>> >> +     local dev=$1
>> >> +     local key=$2
>> >> +
>> >> +     $NDCTL_PROG list | \
>> >> +       $JQ_PROG -r ".[] | \
>> >> +       select(.blockdev == \"${dev#/dev/}\") | .$key"
>> >> +}
>> >> +
>> >> +# Require pmem device having specific arttibute key/value
>> >> +# we need.
>> >> +_require_pmem_key_value()
>> >> +{
>> >> +     local dev=$1
>> >> +     local key=$2
>> >> +     local value=$3
>> >> +
>> >> +     [[ ! "${dev#/dev/}" =~ pmem ]] && \
>> >> +       _notrun "this test requires pmem device"
>> >> +
>> >> +     # if pmem devices are setup by memmap, just run
>> >> +     grep -q memmap /proc/cmdline && return
>> >> +
>> >> +     # pmem devices from NFIT
>> >> +     _require_command "$NDCTL_PROG" "ndctl"
>> >> +     _require_command "$JQ_PROG" "jq"
>> >> +     # get dev specific attr
>> >> +     dev_value=$(_ndctl_get_pmem_key_value $dev $key)
>> >> +     [ "$dev_value" != "$value" ] && \
>> >> +       _notrun "this test requires $dev $value $key"
>> >
>> > This is too ugly. I'm looking for another way by searching sysfs for
>> > required info of *_DEV, then we don't need these commands and ugly
>> > device name matching.
>> >
>> > Thanks Eryu for the review!
>>
>> Why not just let jq do this key matching validation for you? I don't
>
> I agree with Ross that we don't even need ndctl and jq, if we run tests
> on memmap setup.

I don't understand this comment. How is the test determining if it is
on an memmap defined namespace without querying sysfs?
