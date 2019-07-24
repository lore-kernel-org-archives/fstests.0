Received: from mail.kernel.org ([198.145.29.99]:54364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726316AbfGXQlA (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 24 Jul 2019 12:41:00 -0400
Message-ID: <32a4f98057b9771164a3ae0e3763a5e9b3fdf3e2.camel@kernel.org>
Subject: Re: [PATCH] generic/062: more restrictive namespace for getfattr on
 cephfs
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 24 Jul 2019 12:40:58 -0400
In-Reply-To: <CAOQ4uxiiTPxmGWxygbsDMVShBt89qdoBGByeVa2KOwPqSh70SQ@mail.gmail.com>
References: <20190724145511.1155-1-jlayton@kernel.org>
         <CAOQ4uxiiTPxmGWxygbsDMVShBt89qdoBGByeVa2KOwPqSh70SQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Amir Goldstein <amir73il@gmail.com>
Cc: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Wed, 2019-07-24 at 18:49 +0300, Amir Goldstein wrote:
> On Wed, Jul 24, 2019 at 5:55 PM Jeff Layton <jlayton@kernel.org> wrote:
> > cephfs exposes some information via virtual xattrs and their presence
> > causes this test to fail. When running on cephfs, only search for
> > specific xattr classes to ensure that we skip the ceph.* ones.
> > 
> 
> Probably too late to ask this question now anyway, but does ceph have
> a particular good reason to expose those virt xattr in listxattr?
> 
> I means its not xattrs that copy tools should try to copy and tools
> should know about them and can try to getxattr without the need
> to see them in listxattr.
> 
> I noticed this is the behavior of cifs w.r.t cifs. and smb3. virt xattr.
> 

Good question. I don't see the need for us to present these in listxattr
and stopping that may be the best solution here. Let me investigate that
approach.

Thanks,
-- 
Jeff Layton <jlayton@kernel.org>
