Received: from mx1.redhat.com ([209.132.183.28]:50906 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759968AbdDSJup (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 19 Apr 2017 05:50:45 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1492539444-25938-4-git-send-email-amir73il@gmail.com>
References: <1492539444-25938-4-git-send-email-amir73il@gmail.com> <1492539444-25938-1-git-send-email-amir73il@gmail.com>
Subject: Re: [PATCH 3/4] fstests: add helper _require_exportfs
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9866.1492595442.1@warthog.procyon.org.uk>
Date: Wed, 19 Apr 2017 10:50:42 +0100
Message-ID: <9867.1492595442@warthog.procyon.org.uk>
Sender: fstests-owner@vger.kernel.org
To: Amir Goldstein <amir73il@gmail.com>
Cc: dhowells@redhat.com, Eryu Guan <eguan@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>, Trond Myklebust <trondmy@primarydata.com>, Jeff Layton <jlayton@poochiereds.net>, "J . Bruce Fields" <bfields@fieldses.org>, fstests@vger.kernel.org, linux-unionfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Amir Goldstein <amir73il@gmail.com> wrote:

> +# Does NFS export work on this fs?
> +_require_exportfs()

Don't forget to add it to doc/requirement-checking.txt!

David
