Received: from mail-oi0-f44.google.com ([209.85.218.44]:36010 "EHLO
        mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754393AbdDQWyb (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 17 Apr 2017 18:54:31 -0400
Received: by mail-oi0-f44.google.com with SMTP id r203so157996349oib.3
        for <fstests@vger.kernel.org>; Mon, 17 Apr 2017 15:54:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAPcyv4g_+hWc4KbnvBnSsyDzwGxMaObfOfxEWqpwO_r1-iieug@mail.gmail.com>
References: <1492008380-29164-1-git-send-email-xzhou@redhat.com>
 <1492413255-11146-1-git-send-email-xzhou@redhat.com> <1492413255-11146-3-git-send-email-xzhou@redhat.com>
 <CAPcyv4g_+hWc4KbnvBnSsyDzwGxMaObfOfxEWqpwO_r1-iieug@mail.gmail.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 17 Apr 2017 15:54:30 -0700
Message-ID: <CAPcyv4hUut86oUm=W=nUJ9tHajYaTK=RAzHge_UYhjHKufP6Fw@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] generic: test mmap io fom DAX to non-DAX
Content-Type: text/plain; charset=UTF-8
Sender: fstests-owner@vger.kernel.org
To: Xiong Zhou <xzhou@redhat.com>
Cc: fstests@vger.kernel.org, Ross Zwisler <ross.zwisler@linux.intel.com>, jmoyer <jmoyer@redhat.com>, Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

On Mon, Apr 17, 2017 at 7:14 AM, Dan Williams <dan.j.williams@intel.com> wrote:
> On Mon, Apr 17, 2017 at 12:14 AM, Xiong Zhou <xzhou@redhat.com> wrote:
>> Mount TEST_DEV as non-DAX, SCRATCH_DEV as DAX, then
>> do mmap DIO from DAX to non-DAX.
>>
>> This test is split from generic/413. Since DIO from DAX
>> to non-DAX is only supported/doable when device underneath
>> has memory(struct page) backend.
>>
>> By ndctl looking at SCRATCH_DEV, skip this test if it is
>> not in "memory mode".
>>
>> Adding helper to check pmem device status, which requires new
>> PROGs ndctl to tweaking pmem devices and jq to parse ndctl's
>> JSON format outputs.
>>
>> Signed-off-by: Xiong Zhou <xzhou@redhat.com>
>> ---
>>  common/rc             |  45 ++++++++++++++++++++
>>  tests/generic/423     | 113 ++++++++++++++++++++++++++++++++++++++++++++++++++
>>  tests/generic/423.out |   2 +
>>  tests/generic/group   |   1 +
>>  4 files changed, 161 insertions(+)
>>  create mode 100755 tests/generic/423
>>  create mode 100644 tests/generic/423.out
>>
>> diff --git a/common/rc b/common/rc
>> index 78a2101..73ac79c 100644
>> --- a/common/rc
>> +++ b/common/rc
>> @@ -3151,6 +3151,51 @@ _require_chattr()
>>         rm -f $TEST_DIR/syscalltest.out
>>  }
>>
>> +# Require test/scratch device nvdimm and having specific
>> +# arttibute key/value we need.
>> +#
>> +# This is designed to get attr values of nvdimm persistent
>> +# memory device, by searching sysfs.
>> +#
>> +# Other non-nvdimm or non-persistent-memory devices would
>> +# fail this helper anyway.
>> +#
>> +# So, ONLY use this helper when you REALLY need nvdimm and
>> +# specific attr on it.
>> +#
>> +_require_pmem_key_value()
>> +{
>> +       local dev=${1#/dev/}
>> +       local key=$2
>> +       local value=$3
>> +       local region index keyfile dev_value
>> +
>> +       # find a filename string contains the region of dev, eg:
>> +       #  /sys/devices/platform/e820_pmem/ndbus0/region1/\
>> +       #  namespace1.0/block/pmem1
>> +       #
>> +       region=$(find /sys/ | grep $dev | grep region | head -1)
>> +       [ -z "$region" ] && \
>> +         _notrun "requires persistent memory $dev $key $value"
>
> Running 'find' in sysfs is overkill. You can go directly to the sysfs
> path for a given block device by stat(1) on the block device special
> file to get the device major and minor numbers. Then go directly to
> the sysfs path for that device by following this link
> /sys/dev/block/$major:$minor.

Of course, this is all handled for you if you just use ndctl, so I'm
not sure what the motivation is to bypass those tools? They are widely
available.
