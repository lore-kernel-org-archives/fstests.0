Received: from mx1.redhat.com ([209.132.183.28]:34164 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751975AbdI2Pwb (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 29 Sep 2017 11:52:31 -0400
Date: Fri, 29 Sep 2017 23:52:28 +0800
From: Zorro Lang <zlang@redhat.com>
Subject: Re: [PATCH] src/nsexec: fix stack pointer alignment exception
Message-ID: <20170929155228.GP21475@dhcp12-143.nay.redhat.com>
References: <20170927055252.12225-1-zlang@redhat.com>
 <3480df1f-d1d0-630d-985f-3dfd33e3ab9d@sandeen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3480df1f-d1d0-630d-985f-3dfd33e3ab9d@sandeen.net>
Sender: fstests-owner@vger.kernel.org
To: Eric Sandeen <sandeen@sandeen.net>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri, Sep 29, 2017 at 09:44:05AM -0500, Eric Sandeen wrote:
> On 9/27/17 12:52 AM, Zorro Lang wrote:
> > When test g/317 or g/318 on ARM server, we got a kernel exception:
> > 
> >   kernel: nsexec[8203]: SP Alignment exception: pc=00000000004010a0 sp=00000000005200e8
> > 
> > nsexec gives an unaligned child stack address to clone() system
> > call sometimes. For making sure it's always aligned, use
> > "__attribute__((aligned))" extension of GCC (Thanks this suggestion
> > from Eric sandeen).
> > 
> > Signed-off-by: Zorro Lang <zlang@redhat.com>
> > ---
> >  src/nsexec.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/src/nsexec.c b/src/nsexec.c
> > index f033b1a4..205dd081 100644
> > --- a/src/nsexec.c
> > +++ b/src/nsexec.c
> > @@ -138,7 +138,8 @@ childFunc(void *arg)
> >  
> >  #define STACK_SIZE (1024 * 1024)
> >  
> > -static char child_stack[STACK_SIZE];    /* Space for child's stack */
> > +/* Space for child's stack */
> > +static char __attribute__((aligned)) child_stack[STACK_SIZE];
> 
> Does it matter if the __attribute__ goes before or after
> the array name (child_stack[])?  I can't quite tell from reading i.e.
> https://gcc.gnu.org/onlinedocs/gcc-3.1/gcc/Variable-Attributes.html#Variable%20Attributes
> if it does, though most examples I see have the __attribute__ after the variable
> name, i.e.

Sorry, I didn't notice this "before/after" problem. Yes, you're right,
everyone use "__attribute__" at the end. I'll change that.

BTW, using it in the middle works (compile and run) fine from my side.

Thanks,
Zorro

> 
> > short array[3] __attribute__ ((aligned));
> 
> in the URL above.
> 
> -Eric
> 
> >  
> >  int
> >  main(int argc, char *argv[])
> > 
