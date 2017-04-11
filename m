Received: from mx1.redhat.com ([209.132.183.28]:47994 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752450AbdDKNy0 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 11 Apr 2017 09:54:26 -0400
From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [PATCH v2 2/3] DAX-DIO: skip DAX to non-DAX if unsupported
References: <20170407171600.GA29489@linux.intel.com>
        <1491804353-1326-1-git-send-email-xzhou@redhat.com>
        <1491804353-1326-2-git-send-email-xzhou@redhat.com>
        <20170411114410.GJ22845@eguan.usersys.redhat.com>
Date: Tue, 11 Apr 2017 09:54:22 -0400
In-Reply-To: <20170411114410.GJ22845@eguan.usersys.redhat.com> (Eryu Guan's
        message of "Tue, 11 Apr 2017 19:44:10 +0800")
Message-ID: <x49d1cjjbht.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: Xiong Zhou <xzhou@redhat.com>, fstests@vger.kernel.org, ross.zwisler@linux.intel.com, dan.j.williams@intel.com
List-ID: <fstests@vger.kernel.org>

Eryu Guan <eguan@redhat.com> writes:

> On Mon, Apr 10, 2017 at 02:05:52PM +0800, Xiong Zhou wrote:
>> By tweaking SCRATCH_DEV by ndctl, only run DAX mapped
>> area DIO to non-DAX area tests when pmem device is in
>> "memory mode".
>> 
>> Signed-off-by: Xiong Zhou <xzhou@redhat.com>

> I'm not sure if it's proper to change the pmem device mode in tests.
> IMO, fstests just takes use of user specified TEST|SCRATCH_DEV and
> checks if they meet our requirements.
>
> So I think the correct way is just check the mode of pmem device and
> _notrun if the mode isn't compatible with this test.

It's a scratch device, so I see no issue with changing the mode.  If you
don't allow this, then we'll need to run through the tests several times
with different configurations just to get full coverage.

-Jeff
