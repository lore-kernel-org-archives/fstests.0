Received: from sandeen.net ([63.231.237.45]:52695 "EHLO sandeen.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752257AbbLVWgB (ORCPT <rfc822;fstests@vger.kernel.org>);
	Tue, 22 Dec 2015 17:36:01 -0500
Subject: Re: [PATCH 6/6] fsx: Add mechanism to replay failed operations
References: <1450817636-11416-1-git-send-email-agruenba@redhat.com>
 <1450817636-11416-7-git-send-email-agruenba@redhat.com>
 <5679C53A.4010905@sandeen.net>
 <CAHc6FU5CsYbUJsUyWqWVfwY0OaiqOsy+BzxRS7dw5S+zfFJ+pw@mail.gmail.com>
From: Eric Sandeen <sandeen@sandeen.net>
Message-ID: <5679D04F.6000803@sandeen.net>
Date: Tue, 22 Dec 2015 16:35:59 -0600
MIME-Version: 1.0
In-Reply-To: <CAHc6FU5CsYbUJsUyWqWVfwY0OaiqOsy+BzxRS7dw5S+zfFJ+pw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On 12/22/15 4:12 PM, Andreas Gruenbacher wrote:
> On Tue, Dec 22, 2015 at 10:48 PM, Eric Sandeen <sandeen@sandeen.net> wrote:

>> Can't we just leverage what fsx already provides?  I'm not sure what this
>> patch adds on top of that, am I missing something?
> 
> The -S and -D options help narrow down problems somewhat (xfstests
> always seems to use a constant seed value), but they don't allow
> removing unrelated operations in between or changing the order of
> operations. The .fsxops file makes that very easy; I've successfully
> used it on a gfs2 bug.

Now that you mention it, I guess I've done the same thing in the past
as well; I see the difference now.  :)

-Eric
