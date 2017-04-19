Received: from mx1.redhat.com ([209.132.183.28]:43646 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1761004AbdDSIks (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 19 Apr 2017 04:40:48 -0400
Date: Wed, 19 Apr 2017 16:40:45 +0800
From: Xiong Zhou <xzhou@redhat.com>
Subject: Re: [PATCH v4 2/4] generic: test mmap io fom DAX to non-DAX
Message-ID: <20170419084045.fquoubljwnxwwq4y@XZHOUW.usersys.redhat.com>
References: <1492008380-29164-1-git-send-email-xzhou@redhat.com>
 <1492413255-11146-1-git-send-email-xzhou@redhat.com>
 <1492413255-11146-3-git-send-email-xzhou@redhat.com>
 <CAPcyv4g_+hWc4KbnvBnSsyDzwGxMaObfOfxEWqpwO_r1-iieug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4g_+hWc4KbnvBnSsyDzwGxMaObfOfxEWqpwO_r1-iieug@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>
Cc: Xiong Zhou <xzhou@redhat.com>, fstests@vger.kernel.org, Ross Zwisler <ross.zwisler@linux.intel.com>, jmoyer <jmoyer@redhat.com>, Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

On Mon, Apr 17, 2017 at 07:14:32AM -0700, Dan Williams wrote:
> On Mon, Apr 17, 2017 at 12:14 AM, Xiong Zhou <xzhou@redhat.com> wrote:
> > Mount TEST_DEV as non-DAX, SCRATCH_DEV as DAX, then
> > do mmap DIO from DAX to non-DAX.
> >
> > This test is split from generic/413. Since DIO from DAX
> > to non-DAX is only supported/doable when device underneath
> > has memory(struct page) backend.
> >
> > By ndctl looking at SCRATCH_DEV, skip this test if it is
> > not in "memory mode".
> >
> > Adding helper to check pmem device status, which requires new
> > PROGs ndctl to tweaking pmem devices and jq to parse ndctl's
> > JSON format outputs.
> >
> > Signed-off-by: Xiong Zhou <xzhou@redhat.com>
> > ---
> >  common/rc             |  45 ++++++++++++++++++++
> >  tests/generic/423     | 113 ++++++++++++++++++++++++++++++++++++++++++++++++++
> >  tests/generic/423.out |   2 +
> >  tests/generic/group   |   1 +
> >  4 files changed, 161 insertions(+)
> >  create mode 100755 tests/generic/423
> >  create mode 100644 tests/generic/423.out
> >
> > diff --git a/common/rc b/common/rc
> > index 78a2101..73ac79c 100644
> > --- a/common/rc
> > +++ b/common/rc
> > @@ -3151,6 +3151,51 @@ _require_chattr()
> >         rm -f $TEST_DIR/syscalltest.out
> >  }
> >
> > +# Require test/scratch device nvdimm and having specific
> > +# arttibute key/value we need.
> > +#
> > +# This is designed to get attr values of nvdimm persistent
> > +# memory device, by searching sysfs.
> > +#
> > +# Other non-nvdimm or non-persistent-memory devices would
> > +# fail this helper anyway.
> > +#
> > +# So, ONLY use this helper when you REALLY need nvdimm and
> > +# specific attr on it.
> > +#
> > +_require_pmem_key_value()
> > +{
> > +       local dev=${1#/dev/}
> > +       local key=$2
> > +       local value=$3
> > +       local region index keyfile dev_value
> > +
> > +       # find a filename string contains the region of dev, eg:
> > +       #  /sys/devices/platform/e820_pmem/ndbus0/region1/\
> > +       #  namespace1.0/block/pmem1
> > +       #
> > +       region=$(find /sys/ | grep $dev | grep region | head -1)
> > +       [ -z "$region" ] && \
> > +         _notrun "requires persistent memory $dev $key $value"
> 
> Running 'find' in sysfs is overkill. You can go directly to the sysfs
> path for a given block device by stat(1) on the block device special
> file to get the device major and minor numbers. Then go directly to
> the sysfs path for that device by following this link

> /sys/dev/block/$major:$minor.

This sounds better. While I have trouble with getting the right region
mode through this sysfs path.

sh-4.2# ndctl list -r 2 -N
{
  "dev":"namespace2.0",
  "mode":"raw",
  "size":8589934592,
  "blockdev":"pmem2"
}
sh-4.2# cat /sys/devices/LNXSYSTM:00/device:00/ACPI0012:00/ndbus0/region2/namespace2.0/mode
raw
sh-4.2# stat -c %t:%T /dev/pmem2
103:2
sh-4.2# cat /sys/dev/block/259\:2/device/mode
raw
sh-4.2# ndctl create-namespace -f -e namespace2.0 -m memory
{
  "dev":"namespace2.0",
  "mode":"memory",
  "size":8453619712,
  "uuid":"66d5afc1-6876-4e8b-a0ba-0082af84bf82",
  "blockdev":"pmem2"
}
sh-4.2# stat -c %t:%T /dev/pmem2
103:2
sh-4.2# cat /sys/dev/block/259\:2/device/mode     # Here
pmem
sh-4.2# cat /sys/devices/LNXSYSTM:00/device:00/ACPI0012:00/ndbus0/region2/namespace2.0/mode
memory
sh-4.2# ndctl list -r 2 -N
{
  "dev":"namespace2.0",
  "mode":"memory",
  "size":8453619712,
  "uuid":"66d5afc1-6876-4e8b-a0ba-0082af84bf82",
  "blockdev":"pmem2"
}
sh-4.2# 
