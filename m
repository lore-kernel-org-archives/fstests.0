Received: from mx1.redhat.com ([209.132.183.28]:1910 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753080AbdDKN4Q (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 11 Apr 2017 09:56:16 -0400
From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [PATCH v2 3/3] DAX: mmap write readonly file
References: <20170407171600.GA29489@linux.intel.com>
        <1491804353-1326-1-git-send-email-xzhou@redhat.com>
        <1491804353-1326-3-git-send-email-xzhou@redhat.com>
        <20170411114619.GK22845@eguan.usersys.redhat.com>
Date: Tue, 11 Apr 2017 09:56:14 -0400
In-Reply-To: <20170411114619.GK22845@eguan.usersys.redhat.com> (Eryu Guan's
        message of "Tue, 11 Apr 2017 19:46:19 +0800")
Message-ID: <x498tn7jbep.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: Xiong Zhou <xzhou@redhat.com>, fstests@vger.kernel.org, ross.zwisler@linux.intel.com, dan.j.williams@intel.com
List-ID: <fstests@vger.kernel.org>

Eryu Guan <eguan@redhat.com> writes:

> On Mon, Apr 10, 2017 at 02:05:53PM +0800, Xiong Zhou wrote:
>> Regression case that one can write to read-only
>> file in a DAX mountpoint.
>> 
>> Signed-off-by: Xiong Zhou <xzhou@redhat.com>
>> ---
>> 
>> v2:
>>   compile test programme manually in this test because default
>> cc option -O2 prevents this issue reproduction;
>
> Hmm, this looks.. ugly to me :) Better to find out the exact reason that
> prevents the bug from reproducing and update the c program accordingly.

The compiler probably optimizes this bit out:

+	/* fault in the page */
+	foo = *buf;

Cheers,
Jeff
