Received: from mx1.redhat.com ([209.132.183.28]:41712 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750926AbdFAFET (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 1 Jun 2017 01:04:19 -0400
Date: Thu, 1 Jun 2017 13:04:17 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCHv2] src/listxattr: Fix reading past the end of the user
 buffer
Message-ID: <20170601050417.GX23805@eguan.usersys.redhat.com>
References: <1496152288-4101-1-git-send-email-nborisov@suse.com>
 <1496153407-6060-1-git-send-email-nborisov@suse.com>
 <70269450-8b2e-3b8f-e7ac-e44221797e34@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70269450-8b2e-3b8f-e7ac-e44221797e34@suse.com>
Sender: fstests-owner@vger.kernel.org
To: Nikolay Borisov <nborisov@suse.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, May 31, 2017 at 11:58:12AM +0300, Nikolay Borisov wrote:
> 
> 
> On 30.05.2017 17:10, Nikolay Borisov wrote:
> > listxattr reaturns a null-terminated list of entries that represent
> > the xattr names. However, if it is passed larger buffer than it
> > requires it won't zero-out the rest of the memory. The way the
> > loop iterator in listxattr.c is written makes it go print every
> > null-terminated entry up to bufsize (which is user passed parameter).
> > This can lead to a situation where listxattr users N bytes out of
> > M bytes big buffer ( M > N). This will leave the rest (M-N)
> > as garbage, which in turn will be printed by listxattr. Fix this
> > by converting the 'for' loop to 'while' and properly ensuring
> > we are reading at most howevermany elements the syscall reported
> > it returned
> > 
> > Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> > ---
> > 
> > v2: 
> >  Rewrite the loop, hopefully making the code a bit more legible.
> >  Functionally it's the same as my previous fix
> > 
> >  src/listxattr.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/src/listxattr.c b/src/listxattr.c
> > index cd46637a..584ebb2d 100644
> > --- a/src/listxattr.c
> > +++ b/src/listxattr.c
> > @@ -60,10 +60,10 @@ int main(int argc, char **argv)
> >          if (ret < 0) {
> >                  perror("listxattr");
> >          } else {
> > -                char *l;
> > -                for (l = buf; l != (buf + bufsize) && *l != '\0';
> > -                                l = strchr(l, '\0') + 1) {
> > +                char *l = buf;
> > +                while (l != (buf + ret)) {
> 
> Actually I believe while (l < (buf + ret)) is the correct form.

Fixed while committing, thanks for the update!

Eryu

> 
> >                          printf("xattr: %s\n", l);
> > +                        l = strchr(l, '\0') + 1;
> >                  }
> >          }
> >  
> > 
