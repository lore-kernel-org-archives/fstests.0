Received: from mail-wr0-f178.google.com ([209.85.128.178]:32830 "EHLO
        mail-wr0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967252AbdD0LyK (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 27 Apr 2017 07:54:10 -0400
MIME-Version: 1.0
Reply-To: mtk.manpages@gmail.com
In-Reply-To: <CA+55aFwUwQCJQFur67_FF3=5L1-q5P32JTm+TwPadKYnOo1B-A@mail.gmail.com>
References: <149324135581.24512.17200609423997054366.stgit@warthog.procyon.org.uk>
 <CA+55aFwUwQCJQFur67_FF3=5L1-q5P32JTm+TwPadKYnOo1B-A@mail.gmail.com>
From: "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Date: Thu, 27 Apr 2017 13:53:47 +0200
Message-ID: <CAKgNAkhBa6yiwY3unzxnK6TZ5umZUNTWxpXt1C9odHXfpcBuJg@mail.gmail.com>
Subject: Re: [PATCH] statx: Kill fd-with-NULL-path support in favour of AT_EMPTY_PATH
Content-Type: text/plain; charset=UTF-8
Sender: fstests-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Howells <dhowells@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>, linux-man <linux-man@vger.kernel.org>, Linux API <linux-api@vger.kernel.org>, Eric Sandeen <sandeen@sandeen.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, fstests <fstests@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Michael Kerrisk <mtk.manpages@gmail.com>, Christoph Hellwig <hch@infradead.org>
List-ID: <fstests@vger.kernel.org>

On 27 April 2017 at 00:03, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> On Wed, Apr 26, 2017 at 2:15 PM, David Howells <dhowells@redhat.com> wrote:
>> [!] NOTE: This breaks UAPI introduced in 4.11-rc1.
>
> Ugh.
>
> I'm, applying this now, so that we don't end up with a released kernel
> that supports the NULL filename thing.
>
> I'm not happy about the timing though. And I hope nobody started using
> statx() outside of tests.

Agreed on the timing. Late review on my part didn't help.

But, also, David's fix is not quite right. I will send a patch.

Cheers,

Michael

-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
