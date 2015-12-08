Received: from sandeen.net ([63.231.237.45]:36699 "EHLO sandeen.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751033AbbLHRVS (ORCPT <rfc822;fstests@vger.kernel.org>);
	Tue, 8 Dec 2015 12:21:18 -0500
Subject: Re: [PATCH] xfs/133: add quota name beginning with digits test
References: <1449244857-19283-1-git-send-email-zlang@redhat.com>
From: Eric Sandeen <sandeen@sandeen.net>
Message-ID: <5667118D.2000502@sandeen.net>
Date: Tue, 8 Dec 2015 11:21:17 -0600
MIME-Version: 1.0
In-Reply-To: <1449244857-19283-1-git-send-email-zlang@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org
Cc: eguan@redhat.com, sandeen@redhat.com
List-ID: <fstests@vger.kernel.org>

On 12/4/15 10:00 AM, Zorro Lang wrote:
> There're two bugs on xfsprogs:
> 1. when a project name beinning with digits, it can't be found
> by run xfs_quota 'quota -p -v ...' command, but 'report' command
> can find it.
> 
> 2. When user or group names beginning with digits, we can't
> create 'limit' for them, and can't find them either(likes above).
> 
> This case will create user, group and project names which beginning
> with digits, then create limit for them, and query them.
> 
> Signed-off-by: Zorro Lang <zlang@redhat.com>
> ---
> 
> Hi,
> 
> This case need a test user, that doesn't like user 'fsqa', fsqa is a
> common user for xfstests, but this case need a special and temporary
> user and group. So I create and clean them in this case.
> 
> But this's the first time a xfstests case add test user/group by itself,
> so please help to review, if this's appropriate?

So, I came to the conclusion, and talking w/ Dave I think he concurs, that it
would be better to document the need for these users in the README; then,
just like the "fsgqa" user, your test can check for the existence of i.e.
a "123456-fsgqa" user, and simply _notrun() if it's not present.  This way
/etc/passwd stays under the system administrator's control, but it's clear why
the test is skipped if the user doesn't exist.
 
-Eric

