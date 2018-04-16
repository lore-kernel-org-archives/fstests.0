Received: from mail.kernel.org ([198.145.29.99]:39254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750946AbeDPL3B (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 16 Apr 2018 07:29:01 -0400
MIME-Version: 1.0
In-Reply-To: <20180409130555.GD2932@desktop>
References: <20180326225921.10096-1-fdmanana@kernel.org> <20180328115530.15563-1-fdmanana@kernel.org>
 <20180408074647.GC2932@desktop> <CAL3q7H5WDP5U-=OcQkRc-+5fD5mNpgscSyqc=M678Tdn8FBHUg@mail.gmail.com>
 <20180409130555.GD2932@desktop>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 16 Apr 2018 12:28:59 +0100
Message-ID: <CAL3q7H6tBnRaH3Y5L8ucPKkHjVCm4fHNzUV8v_XTwwUeeR1oQg@mail.gmail.com>
Subject: Re: [PATCH v2] fstests: test btrfs fsync after hole punching with
 no-holes mode
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <guaneryu@gmail.com>
Cc: fstests <fstests@vger.kernel.org>, linux-btrfs <linux-btrfs@vger.kernel.org>, Filipe Manana <fdmanana@suse.com>
List-ID: <fstests@vger.kernel.org>

On Mon, Apr 9, 2018 at 2:05 PM, Eryu Guan <guaneryu@gmail.com> wrote:
> On Sun, Apr 08, 2018 at 09:46:24AM +0100, Filipe Manana wrote:
>> On Sun, Apr 8, 2018 at 8:46 AM, Eryu Guan <guaneryu@gmail.com> wrote:
>> > On Wed, Mar 28, 2018 at 12:55:30PM +0100, fdmanana@kernel.org wrote:
>> >> From: Filipe Manana <fdmanana@suse.com>
>> >>
>> >> Test that when we have the no-holes mode enabled and a specific metadata
>> >> layout, if we punch a hole and fsync the file, at replay time the whole
>> >> hole was preserved.
>> >>
>> >> This issue is fixed by the following btrfs patch for the linux kernel:
>> >>
>> >>   "Btrfs: fix fsync after hole punching when using no-holes feature"
>> >>
>> >> Signed-off-by: Filipe Manana <fdmanana@suse.com>
>> >> ---
>> >>
>> >> V2: Made the test work when selinux is enabled, and made it use direct IO
>> >>     writes to ensure 256K extents.
>> >
>> > Test fails with selinux enabled now on unpatched kernel. But I found
>> > that, in my release testing, test still fails when testing with current
>> > Linus tree (HEAD is 642e7fd23353, without selinux this time), which
>> > should contain the mentioned fix. Does that mean the bug is not fully
>> > fixed?
>>
>> The bug is fully fixed. But HEAD 642e7fd23353 does not contain the
>> fix. The current  linus' master has it.
>
> I'll double check.. Thanks for the heads-up!

Hi Eryu, any reason this didn't go in the last update?
Thanks.

>
> Eryu
