Received: from mga11.intel.com ([192.55.52.93]:9097 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752636AbdDQXjH (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 17 Apr 2017 19:39:07 -0400
Date: Mon, 17 Apr 2017 17:39:05 -0600
From: Ross Zwisler <ross.zwisler@linux.intel.com>
Subject: Re: [PATCH v4 2/4] generic: test mmap io fom DAX to non-DAX
Message-ID: <20170417233905.GA26616@linux.intel.com>
References: <1492008380-29164-1-git-send-email-xzhou@redhat.com>
 <1492413255-11146-1-git-send-email-xzhou@redhat.com>
 <1492413255-11146-3-git-send-email-xzhou@redhat.com>
 <CAPcyv4g_+hWc4KbnvBnSsyDzwGxMaObfOfxEWqpwO_r1-iieug@mail.gmail.com>
 <CAPcyv4hUut86oUm=W=nUJ9tHajYaTK=RAzHge_UYhjHKufP6Fw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4hUut86oUm=W=nUJ9tHajYaTK=RAzHge_UYhjHKufP6Fw@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>
Cc: Xiong Zhou <xzhou@redhat.com>, fstests@vger.kernel.org, Ross Zwisler <ross.zwisler@linux.intel.com>, jmoyer <jmoyer@redhat.com>, Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

On Mon, Apr 17, 2017 at 03:54:30PM -0700, Dan Williams wrote:
> On Mon, Apr 17, 2017 at 7:14 AM, Dan Williams <dan.j.williams@intel.com> wrote:
> > On Mon, Apr 17, 2017 at 12:14 AM, Xiong Zhou <xzhou@redhat.com> wrote:
> >> Mount TEST_DEV as non-DAX, SCRATCH_DEV as DAX, then
> >> do mmap DIO from DAX to non-DAX.
> >>
> >> This test is split from generic/413. Since DIO from DAX
> >> to non-DAX is only supported/doable when device underneath
> >> has memory(struct page) backend.
> >>
> >> By ndctl looking at SCRATCH_DEV, skip this test if it is
> >> not in "memory mode".
> >>
> >> Adding helper to check pmem device status, which requires new
> >> PROGs ndctl to tweaking pmem devices and jq to parse ndctl's
> >> JSON format outputs.
> >>
> >> Signed-off-by: Xiong Zhou <xzhou@redhat.com>
> >> ---
> >>  common/rc             |  45 ++++++++++++++++++++
> >>  tests/generic/423     | 113 ++++++++++++++++++++++++++++++++++++++++++++++++++
> >>  tests/generic/423.out |   2 +
> >>  tests/generic/group   |   1 +
> >>  4 files changed, 161 insertions(+)
> >>  create mode 100755 tests/generic/423
> >>  create mode 100644 tests/generic/423.out
> >>
> >> diff --git a/common/rc b/common/rc
> >> index 78a2101..73ac79c 100644
> >> --- a/common/rc
> >> +++ b/common/rc
> >> @@ -3151,6 +3151,51 @@ _require_chattr()
> >>         rm -f $TEST_DIR/syscalltest.out
> >>  }
> >>
> >> +# Require test/scratch device nvdimm and having specific
> >> +# arttibute key/value we need.
> >> +#
> >> +# This is designed to get attr values of nvdimm persistent
> >> +# memory device, by searching sysfs.
> >> +#
> >> +# Other non-nvdimm or non-persistent-memory devices would
> >> +# fail this helper anyway.
> >> +#
> >> +# So, ONLY use this helper when you REALLY need nvdimm and
> >> +# specific attr on it.
> >> +#
> >> +_require_pmem_key_value()
> >> +{
> >> +       local dev=${1#/dev/}
> >> +       local key=$2
> >> +       local value=$3
> >> +       local region index keyfile dev_value
> >> +
> >> +       # find a filename string contains the region of dev, eg:
> >> +       #  /sys/devices/platform/e820_pmem/ndbus0/region1/\
> >> +       #  namespace1.0/block/pmem1
> >> +       #
> >> +       region=$(find /sys/ | grep $dev | grep region | head -1)
> >> +       [ -z "$region" ] && \
> >> +         _notrun "requires persistent memory $dev $key $value"
> >
> > Running 'find' in sysfs is overkill. You can go directly to the sysfs
> > path for a given block device by stat(1) on the block device special
> > file to get the device major and minor numbers. Then go directly to
> > the sysfs path for that device by following this link
> > /sys/dev/block/$major:$minor.
> 
> Of course, this is all handled for you if you just use ndctl, so I'm
> not sure what the motivation is to bypass those tools? They are widely
> available.

Yea, I think I may have lead Xiong in the wrong direction.  :-/  I thought
that we didn't need to worry about the case where we had both NFIT generated
PMEM devices and memmap generated PMEM devices, and if that was true we could
basically have a shortcut in the memmap case and not add the extra
dependencies of ndctl and jq.

In thinking about it a bit more, though, I think Dan's right about that
basically being a premature optimization.  We probably do need to consider
that case, and future-proof ourselves against other non-NFIT PMEM regions on
other architectures.  The sysfs interface isn't meant to be stable, though,
and ndctl is stable, so I think we're better off going back to using ndctl +
jq.  Sorry for the thrash.

I think your v3 changes in common/rc do exactly what you need, and you just
need to pull out the lines that special case the memmap case and you're done.
