Received: from mail-it0-f44.google.com ([209.85.214.44]:35394 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932261AbdDZWDv (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 26 Apr 2017 18:03:51 -0400
MIME-Version: 1.0
In-Reply-To: <149324135581.24512.17200609423997054366.stgit@warthog.procyon.org.uk>
References: <149324135581.24512.17200609423997054366.stgit@warthog.procyon.org.uk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 26 Apr 2017 15:03:50 -0700
Message-ID: <CA+55aFwUwQCJQFur67_FF3=5L1-q5P32JTm+TwPadKYnOo1B-A@mail.gmail.com>
Subject: Re: [PATCH] statx: Kill fd-with-NULL-path support in favour of AT_EMPTY_PATH
Content-Type: text/plain; charset=UTF-8
Sender: fstests-owner@vger.kernel.org
To: David Howells <dhowells@redhat.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, linux-man@vger.kernel.org, Linux API <linux-api@vger.kernel.org>, Eric Sandeen <sandeen@sandeen.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, fstests@vger.kernel.org, Michael Kerrisk <mtk.manpages@gmail.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Wed, Apr 26, 2017 at 2:15 PM, David Howells <dhowells@redhat.com> wrote:
> [!] NOTE: This breaks UAPI introduced in 4.11-rc1.

Ugh.

I'm, applying this now, so that we don't end up with a released kernel
that supports the NULL filename thing.

I'm not happy about the timing though. And I hope nobody started using
statx() outside of tests.

                 Linus
